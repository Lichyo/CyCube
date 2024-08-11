import 'package:cy_cube/cube/cube_state.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:async';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class ARPage extends StatefulWidget {
  ARPage({super.key, required this.cameras});

  List<CameraDescription> cameras;

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  Offset _offset = Offset.zero;
  CubeState cubeState = CubeState();
  String? roomID;
  int arrangeCountX = 0;
  int arrangeCountY = 0;
  double dy = 0;
  double dx = 0;
  bool isSendWarning = false;
  late IO.Socket _socket;
  late CameraController controller;
  late Timer _timer;
  late CameraImage imageBuffer;
  Image? imageInWidget1;
  Image? imageInWidget2;
  bool toggle = true;

  @override
  void initState() {
    super.initState();
    cubeState.setOnStateChange(() {
      setState(() {});
    });
    _socket = IO.io('http://192.168.50.22:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connect', (_) {
      print('connected');
    });
    _socket.on('receive_image', (data) {
      if (toggle) {
        imageInWidget1 = Image.memory(base64Decode(data));
      } else {
        imageInWidget2 = Image.memory(base64Decode(data));
      }
      setState(() {
        toggle = !toggle;
      });
    });
    _socket.on('save_image', (data) {
      print(data);
    });
    _socket.on('disconnect', (_) {
      print('disconnected');
    });

    controller = CameraController(widget.cameras[0], ResolutionPreset.low);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      if (controller.value.isInitialized) {
        controller.startImageStream((image) {
          imageBuffer = image;
        });
      }
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cubeState.setOnStateChange(null);
    _socket.dispose();
    controller.stopImageStream();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onPanUpdate: (detail) {
          setState(() {
            _offset += detail.delta;
            if (arrangeCountY == 0) {
              dx = _offset.dx;
            }

            if (_offset.dy < 50 && _offset.dy > -50) {
              dy += detail.delta.dy;
            }

            if ((dx / 90).floor() < arrangeCountX - 1 && arrangeCountY == 0) {
              arrangeCountX--;
              cubeState.listenToArrange(arrangeSide: 'right');
            } else if ((dx / 90).floor() > arrangeCountX - 1 &&
                arrangeCountY == 0) {
              arrangeCountX++;
              cubeState.listenToArrange(arrangeSide: 'left');
            } else if (arrangeCountY != 0 && isSendWarning == false) {}

            if ((_offset.dy / 90).floor() + 1 > 0 && arrangeCountY == 0) {
              arrangeCountY++;
              cubeState.listenToArrange(arrangeSide: 'up');
            } else if ((_offset.dy / 90).floor() + 1 == 0 &&
                arrangeCountY == 1) {
              arrangeCountY--;
              cubeState.listenToArrange(arrangeSide: 'down');
            }
          });
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: Text(
              roomID ?? 'CyCube',
              style: GoogleFonts.aboreto(
                fontSize: 27.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              if (imageInWidget1 != null)
                Opacity(
                  opacity: toggle ? 1.0 : 0.0,
                  child: imageInWidget1!,
                ),
              if (imageInWidget2 != null)
                Opacity(
                  opacity: toggle ? 0.0 : 1.0,
                  child: imageInWidget2!,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MaxGap(200),
                  Transform(
                    origin: const Offset(0, 0),
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(dy * pi / 180)
                      ..rotateY(dx * pi / 180)
                      ..setEntry(2, 2, 0.001),
                    child: Center(
                      child: Cube(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(Uint8List sendMsg) {
    _socket.emit('save_image', base64Encode(sendMsg));
  }

  Future<Uint8List> convertCameraImageToJpeg(CameraImage image) async {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    var imgBuffer = img.Image(width, height);

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;

        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];

        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);

        imgBuffer.setPixel(x, y, img.getColor(r, g, b));
      }
    }
    imgBuffer = img.copyRotate(imgBuffer, 90);
    img.JpegEncoder jpegEncoder = img.JpegEncoder();
    List<int> jpeg = jpegEncoder.encodeImage(imgBuffer);
    return Uint8List.fromList(jpeg);
  }
}

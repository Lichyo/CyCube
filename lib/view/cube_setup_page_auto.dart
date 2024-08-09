import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:cy_cube/components/single_cube_face.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:gap/gap.dart';

class CubeSetupPageAuto extends StatefulWidget {
  CubeSetupPageAuto({
    super.key,
    required this.cameras,
  });

  List<CameraDescription> cameras;

  @override
  State<CubeSetupPageAuto> createState() => _CubeSetupPageAutoState();
}

class _CubeSetupPageAutoState extends State<CubeSetupPageAuto> {
  late IO.Socket _socket;
  late CameraController controller;
  late Timer _timer;
  late CameraImage imageBuffer;
  Image? imageInWidget1;
  Image? imageInWidget2;
  bool toggle = true;
  List<SingleCubeComponentFaceModel> cubeFaces = [];
  List<List<SingleCubeComponentFaceModel>> allCubeFaces = [];

  void initCubeFaces() {
    cubeFaces = [];
    for (int i = 0; i < 9; i++) {
      cubeFaces.add(SingleCubeComponentFaceModel(id: i));
    }
  }

  @override
  void initState() {
    super.initState();
    initCubeFaces();
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
    _socket.on('return_cube_color', (data) {
      setState(() {
        try {
          List<String> cubeColors = List<String>.from(data);
          for (int i = 0; i < 9; i++) {
            cubeFaces[i].color = getColor(cubeColors[i]);
          }
        } catch (e) {
          print(e);
        }
      });
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

  Color getColor(String color) {
    switch (color) {
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cube Setup Auto'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
            convertCameraImageToJpeg(imageBuffer).then((value) {
              _sendMessage(value);
            });
            _socket.emit('receive_image', 'send');
          });
        },
        child: const Icon(Icons.send),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
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
              ],
            ),
            const MaxGap(50),
            SingleCubeFace(singleCubeComponentFaces: cubeFaces),
            TextButton(
              onPressed: () {
                setState(() {
                  allCubeFaces.add(cubeFaces);
                  initCubeFaces();
                });
                if (allCubeFaces.length == 6) {
                  Navigator.pop(context, [allCubeFaces]);
                }
              },
              child: const Text('Next Face'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(Uint8List sendMsg) {
    _socket.emit('save_image', base64Encode(sendMsg));
  }

  @override
  void dispose() {
    _socket.dispose();
    controller.stopImageStream();
    _timer.cancel();
    super.dispose();
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

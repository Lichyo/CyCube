import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late IO.Socket _socket;
  late CameraController controller;
  late Timer _timer;
  late CameraImage imageBuffer;
  Image? imageInWidget1;
  Image? imageInWidget2;
  bool toggle = true;
  bool startCourse = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socket = IO.io('http://192.168.50.22:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connect', (_) {
      print('connected');
    });
    _socket.on('save_image', (data) {
      print(data);
    });
    _socket.on('predict', (data) {
      print(data);
    });
    _socket.on('disconnect', (_) {
      print('disconnected');
    });

    controller = CameraController(widget.cameras[1], ResolutionPreset.low);
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (startCourse) {
            _timer.cancel();
            startCourse = false;
          } else {
            _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
              convertCameraImageToJpeg(imageBuffer).then((value) {
                _socket.emit('predict', base64Encode(value));
              });
              print('send image');
            });
            startCourse = true;
          }
        },
        child: const Icon(Icons.camera),
      ),
      appBar: AppBar(
        title: const Text('Course Page'),
      ),
      body: CameraPreview(controller),
    );
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

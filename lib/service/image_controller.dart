import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';

class ImageController {
  static Image? imageInWidget1;
  static Image? imageInWidget2;
  static bool toggle = true;
  static Completer<void>? _imageLoadingCompleter;
  static CameraController? controller;
  static CameraImage? imageBuffer;

  static Color getColor(String color) {
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

  static Future<Uint8List> convertCameraImageToJpeg(CameraImage image) async {
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

  static Future<void> updateImage(String data) async {
    if (_imageLoadingCompleter != null) {
      await _imageLoadingCompleter!.future;
    }
    _imageLoadingCompleter = Completer<void>();
    if (toggle) {
      imageInWidget1 = Image.memory(base64Decode(data));
    } else {
      imageInWidget2 = Image.memory(base64Decode(data));
    }
    toggle = !toggle;
    _imageLoadingCompleter!.complete();
  }

  static flashImage() {
    imageInWidget1 = null;
    imageInWidget2 = null;
  }

  static Future<void> initializeCamera(CameraDescription camera) async {
    controller = CameraController(camera, ResolutionPreset.low);
    try {
      await controller!.initialize();
      controller!.setZoomLevel(0.8);
      if (controller!.value.isInitialized) {
        controller!.startImageStream((image) {
          imageBuffer = image;
        });
      }
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    }
  }

  static void disposeCamera() {
    controller?.dispose();
  }
}

import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

const shift = (0xFF << 24);

class ColorDetectionPage extends StatefulWidget {
  const ColorDetectionPage({super.key});

  @override
  State<ColorDetectionPage> createState() => _ColorDetectionPageState();
}

class _ColorDetectionPageState extends State<ColorDetectionPage> {
  CameraController? _controller;
  Uint8List? _imageBytes;
  late List<CameraDescription> _cameras;
  CameraImage? _cameraImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
    );
    await _controller!.initialize();
    setState(() {});
    await _controller!.startImageStream((CameraImage image) {
      _cameraImage = image;
    });
  }

  Future<void> _captureImage() async {
    if (_cameraImage != null) {
      final img = await convertYUV420toImageColor(_cameraImage!);
      final png = imglib.encodePng(img); // 使用 PNG 编码
      setState(() {
        _imageBytes = Uint8List.fromList(png);
      });
    }
  }

  Future<Image> convertYUV420toImageColor(CameraImage image) async {
    int imageWidth = image.width;
    int imageHeight = image.height;
    int imageStride = image.planes[0].bytesPerRow;
    List<Uint8List> planes = [];
    for (int planeIndex = 0; planeIndex < 3; planeIndex++) {
      Uint8List buffer;
      int width;
      int height;
      if (planeIndex == 0) {
        width = image.width;
        height = image.height;
      } else {
        width = image.width ~/ 2;
        height = image.height ~/ 2;
      }

      buffer = Uint8List(width * height);

      int pixelStride = image.planes[planeIndex].bytesPerPixel!;
      int rowStride = image.planes[planeIndex].bytesPerRow;
      int index = 0;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          buffer[index++] =
              image.planes[planeIndex].bytes[i * rowStride + j * pixelStride];
        }
      }
      planes.add(buffer);
    }
  }

  Uint8List yuv420ToRgba8888(List<Uint8List> planes, int width, int height) {
    final yPlane = planes[0];
    final uPlane = planes[1];
    final vPlane = planes[2];

    final Uint8List rgbaBytes = Uint8List(width * height * 4);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int yIndex = y * width + x;
        final int uvIndex = (y ~/ 2) * (width ~/ 2) + (x ~/ 2);

        final int yValue = yPlane[yIndex] & 0xFF;
        final int uValue = uPlane[uvIndex] & 0xFF;
        final int vValue = vPlane[uvIndex] & 0xFF;

        final int r = (yValue + 1.13983 * (vValue - 128)).round().clamp(0, 255);
        final int g =
            (yValue - 0.39465 * (uValue - 128) - 0.58060 * (vValue - 128))
                .round()
                .clamp(0, 255);
        final int b = (yValue + 2.03211 * (uValue - 128)).round().clamp(0, 255);

        final int rgbaIndex = yIndex * 4;
        rgbaBytes[rgbaIndex] = r.toUnsigned(8);
        rgbaBytes[rgbaIndex + 1] = g.toUnsigned(8);
        rgbaBytes[rgbaIndex + 2] = b.toUnsigned(8);
        rgbaBytes[rgbaIndex + 3] = 255; // Alpha value
      }
    }

    return rgbaBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Detection'),
        actions: [
          TextButton(
            onPressed: (){
            },
            child: const Text('Capture'),
          ),
        ],
      ),
      body: _controller == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                CameraPreview(_controller!),
                if (_imageBytes != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.memory(_imageBytes!),
                  ),
              ],
            ),
    );
  }
}

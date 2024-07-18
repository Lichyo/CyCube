import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'dart:io';

class ColorDetectionPage extends StatefulWidget {
  const ColorDetectionPage({super.key});

  @override
  State<ColorDetectionPage> createState() => _ColorDetectionPageState();
}

class _ColorDetectionPageState extends State<ColorDetectionPage> {
  InputImage? image;
  File? imageFile;
  String? text;
  late ObjectDetector objectDetector;
  final options = ObjectDetectorOptions(
    mode: DetectionMode.single,
    classifyObjects: true,
    multipleObjects: true,
  );

  Future<void> objectDetection(InputImage inputImage) async {
    final List<DetectedObject> objects =
        await objectDetector.processImage(inputImage);
    print('start detection');
    print('==================================\n\n\n\n\n\n\n\n');
    for (DetectedObject detectedObject in objects) {
      final rect = detectedObject.boundingBox;
      final trackingId = detectedObject.trackingId;
      for (Label label in detectedObject.labels) {
        print('${label.text} ${label.confidence}');
      }
    }
    print('==================================\n\n\n\n\n\n\n\n');
    print('end of detection');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objectDetector = ObjectDetector(options: options);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Detection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera),
            onPressed: () async {
              XFile? file = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (file != null) {
                String path = file.path;
                image = InputImage.fromFilePath(path);
                imageFile = File(path);
                await objectDetection(image!);
              }
              setState(() {});
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageFile == null
                ? const Text('No image selected.')
                : Expanded(child: Image.file(imageFile!)),
          ],
        ),
      ),
    );
  }
}

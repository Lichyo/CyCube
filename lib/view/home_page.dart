import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cube/service/detect_object_service.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DetectObjectService service = DetectObjectService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void processImage() async {
    final byteData = await rootBundle.load('assets/images/image.png');
    // img.Image image = img.decodeImage(byteData.buffer.asInt8List());
    final cmd = img.Command()
      ..decodeImageFile('/Users/lichyo/StudioProjects/cube/assets/samples/sample.jpg')
      ..copyResize(width: 224, height: 224)
      ..writeToFile('/Users/lichyo/StudioProjects/cube/assets/samples/new.jpg');
    await cmd.executeThread();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
              onPressed: () async {
                processImage();
              },
              child: const Text(
                'open camera',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
          // Image.asset('assets/samples/sample.jpg'),
        ],
      ),
    );
    // TODO: Hello
  }
}

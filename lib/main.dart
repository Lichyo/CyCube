import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/home_page.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RubiksCube(
        camera: cameras,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'service/cube/cube_rotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RubiksCube());
}

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  String? name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onPanUpdate: (detail) {
          setState(() => _offset += detail.delta * 0.4);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: Text(
              'The Cube',
              style: GoogleFonts.aboreto(
                fontSize: 27.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                origin: const Offset(0, 0),
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(-_offset.dy * pi / 180)
                  ..rotateY(_offset.dx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: Stack(
                    children: CubeRotation().permutateCube(offset: _offset),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              OutlinedButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  Uint8List byte = await image!.readAsBytes();
                  // File('/Users/lichyo/StudioProjects/cube/assets/samples/sample.png')
                  //     .writeAsBytes(byte);
                  FirebaseFirestore fireStore = FirebaseFirestore.instance;
                  fireStore.collection('image').add({
                    'byte': byte,
                  });
                },
                child: const Text('Open Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

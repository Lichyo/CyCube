import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cube/components/cube_face.dart';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RubiksCube());
}

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onPanUpdate: (detail) {
          setState(() => _offset += detail.delta);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: Text(
              'The Cube',
              style: GoogleFonts.aboreto(
                fontSize: 27.0,
                fontWeight: FontWeight.w400
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
                  ..rotateX(_offset.dy * pi / 180)
                  ..rotateY(_offset.dx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: Stack(
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -100.0),
                        child: Container(
                          color: Colors.green,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, 100.0),
                        child: Container(
                          color: Colors.blue,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -100.0)
                          ..rotateY(-pi / 2),
                        child: Container(
                          color: Colors.red,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(200.0, 0.0, -100.0)
                          ..rotateY(-pi / 2),
                        child: Container(
                          color: Colors.orange,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -100.0)
                          ..rotateX(pi / 2),
                        child: Container(
                          color: Colors.black,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -150.0)
                          ..rotateX(pi / 2),
                        child: const CubeFace(
                          color: Colors.white,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, 150.0),
                        child: const CubeFace(
                          color: Colors.yellow,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -150.0)
                          ..rotateY(-pi / 2),
                        child: const CubeFace(
                          color: Colors.green,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(300.0, 0.0, -150.0)
                          ..rotateY(-pi / 2),
                        child: const CubeFace(
                          color: Colors.blue,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0, -150.0)
                          ..rotateX(pi / 2),
                        child: const CubeFace(
                          color: Colors.red,
                        ),
                      ),
                      Transform(
                        origin: const Offset(0, 0),
                        transform: Matrix4.identity()
                          ..translate(0.0, 300.0, -150.0)
                          ..rotateX(pi / 2),
                        child: const CubeFace(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

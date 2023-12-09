import 'package:flutter/material.dart';
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
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
                        transform: Matrix4.identity()
                          ..translate(0.0, 200.0, -100.0)
                          ..rotateX(pi / 2),
                        child: Container(
                          color: Colors.yellow,
                          width: 200,
                          height: 200,
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

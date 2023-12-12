import 'package:flutter/material.dart';
import 'cube_face.dart';
import 'dart:math';
import 'package:cube/constants.dart';

class Cube extends StatelessWidget {
  const Cube({super.key, required this.offset});

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Transform(
            origin: const Offset(0, 0),
            transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
            child: const CubeFace(
              color: Colors.blue,
            ),
          ),
          Transform(
            origin: const Offset(0, 0),
            transform: Matrix4.identity()..translate(0.0, 0.0, 150.0),
            child: const CubeFace(
              color: Colors.green,
            ),
          ),
          Transform(
            origin: const Offset(0, 0),
            transform: Matrix4.identity()
              ..translate(0.0, 0.0, -150.0)
              ..rotateY(-pi / 2),
            child: const CubeFace(
              color: Colors.orange,
            ),
          ),
          Transform(
            origin: const Offset(0, 0),
            transform: Matrix4.identity()
              ..translate(300.0, 0.0, -150.0)
              ..rotateY(-pi / 2),
            child: const CubeFace(
              color: Colors.red,
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
              ..translate(0.0, 300.0, -150.0)
              ..rotateX(pi / 2),
            child: const CubeFace(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}

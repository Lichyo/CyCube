import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:cube/cube/components/cube_face.dart';

enum Facing { green, blue, red, orange, white, yellow }

class CubeRotation {
  // Map<Facing, List<Widget>> cube = {
  //   Facing.green: cubes,
  //   Facing.blue: cubes,
  //   Facing.red: cubes,
  //   Facing.orange: cubes,
  //   Facing.white: cubes,
  //   Facing.yellow: cubes,
  // };
  List<Widget> cubes = [];

  List<Widget> permutateCube({required Offset offset}) {
    Facing facing = _calculateFacing(offset: offset);
    if (facing == Facing.green) {
      return [
        Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, 300.0, -150.0)
            ..rotateX(pi / 2),
          child: const CubeFace(
            color: Colors.yellow,
          ),
        ),
        Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
          child: const CubeFace(
            color: Colors.blue,
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
          transform: Matrix4.identity()..translate(0.0, 0.0, 150.0),
          child: const CubeFace(
            color: Colors.green,
          ),
        ),
      ];
    } else if (facing == Facing.red) {
      return [
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
            ..translate(0.0, 300.0, -150.0)
            ..rotateX(pi / 2),
          child: const CubeFace(
            color: Colors.yellow,
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
            ..rotateX(pi / 2),
          child: const CubeFace(
            color: Colors.white,
          ),
        ),
        Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
          child: const CubeFace(
            color: Colors.blue,
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
      ];
    } else if (facing == Facing.blue) {
      return [
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
            ..translate(0.0, 300.0, -150.0)
            ..rotateX(pi / 2),
          child: const CubeFace(
            color: Colors.yellow,
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
            ..rotateY(-pi / 2),
          child: const CubeFace(
            color: Colors.orange,
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
          transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
          child: const CubeFace(
            color: Colors.blue,
          ),
        ),
      ];
      // } else if (facing == Facing.orange) {
    } else {
      return [
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
            ..translate(0.0, 300.0, -150.0)
            ..rotateX(pi / 2),
          child: const CubeFace(
            color: Colors.yellow,
          ),
        ),
        Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
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
            color: Colors.white,
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
      ];
    }
  }

  Facing _calculateFacing({required Offset offset}) {
    double dx = offset.dx;
    int rotateU = 0;
    while (dx < -90) {
      dx += 90;
      rotateU++;
    }
    while (dx > 90) {
      dx -= 90;
      rotateU--;
    }
    final int facing = rotateU % 4;
    if (facing == 0) {
      return Facing.green;
    } else if (facing == 1) {
      return Facing.red;
    } else if (facing == 2) {
      return Facing.blue;
    } else {
      return Facing.orange;
    }
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cube/cube/components/cube_face.dart';
import '../model/cube_rotate.dart';

enum Facing { top, bottom, left, right, front, back }

class CubeRotation {
  late Rotate currentRotation;
  List<Widget> cubes = [];

  CubeRotation() {
    currentRotation = Rotate();
    updateCube();
  }

  Map<Facing, Widget> cube = {
    Facing.top: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, -150.0)
        ..rotateX(pi / 2),
      child: const CubeFace(
        color: Colors.white,
      ),
    ),
    Facing.bottom: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 300.0, -150.0)
        ..rotateX(pi / 2),
      child: const CubeFace(
        color: Colors.yellow,
      ),
    ),
    Facing.left: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, -150.0)
        ..rotateY(-pi / 2),
      child: const CubeFace(
        color: Colors.orange,
      ),
    ),
    Facing.right: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(300.0, 0.0, -150.0)
        ..rotateY(-pi / 2),
      child: const CubeFace(
        color: Colors.red,
      ),
    ),
    Facing.front: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()..translate(0.0, 0.0, 150.0),
      child: const CubeFace(
        color: Colors.green,
      ),
    ),
    Facing.back: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()..translate(0.0, 0.0, -150.0),
      child: const CubeFace(
        color: Colors.blue,
      ),
    ),
  };

  List<Widget> updateCube() {
    cubes.clear();
    // cubes.add(cube[Facing.bottom]!);
    cubes.add(cube[Facing.back]!);
    // cubes.add(cube[Facing.left]!);
    // cubes.add(cube[Facing.right]!);
    // cubes.add(cube[Facing.top]!);
    cubes.add(cube[Facing.front]!);
    return cubes;
  }

  List<Widget> permutateCube({required Offset offset}) {
    Rotate rotate = _calculateRotation(offset: offset);
    if (rotate.U % 4 == 0) {
    } else if (rotate.U % 4 == 1) {
      _rotateU(rotate);
    } else if (rotate.U % 4 == 2) {
      _rotateU(rotate);
      _rotateU(rotate);
    } else if (rotate.U % 4 == 3) {
      _rotateU(rotate);
      _rotateU(rotate);
      _rotateU(rotate);
    }
    // if (rotate.R % 4 == 0) {
    // } else if (rotate.R % 4 == 1) {
    //   _rotateR();
    // } else if (rotate.R % 4 == 2) {
    //   _rotateR();
    //   _rotateR();
    // } else if (rotate.R % 4 == 3) {
    //   _rotateR();
    //   _rotateR();
    //   _rotateR();
    // }
    return cubes;
  }

  // void _rotateR() {
  //   Widget temp = _cube[Facing.front]!;
  //   _cube[Facing.front] = _cube[Facing.bottom]!;
  //   _cube[Facing.bottom] = _cube[Facing.back]!;
  //   _cube[Facing.back] = _cube[Facing.top]!;
  //   _cube[Facing.top] = temp;
  //
  // }

  void _rotateU(Rotate rotate) {
    if (currentRotation.U < rotate.U) {
      currentRotation.U = rotate.U;
      Widget temp = cube[Facing.left]!;
      cube[Facing.left] = cube[Facing.front]!;
      cube[Facing.front] = cube[Facing.right]!;
      cube[Facing.right] = cube[Facing.back]!;
      cube[Facing.right] = temp;
      print(cubes);
    }
  }

  Rotate _calculateRotation({required Offset offset}) {
    Rotate rotate = Rotate();
    double dx = offset.dx;
    rotate.U = 0;
    while (dx < -90) {
      dx += 90;
      rotate.U++;
    }
    while (dx > 90) {
      dx -= 90;
      rotate.U--;
    }

    print('rotate.U: ${rotate.U}');
    // double dy = offset.dy;
    // rotate.R = 0;
    // while (dy < -90) {
    //   dy += 90;
    //   rotate.R++;
    // }
    // while (dy > 90) {
    //   dy -= 90;
    //   rotate.R--;
    // }
    // print('rotate.R: ${rotate.R}');
    return rotate;
  }
}

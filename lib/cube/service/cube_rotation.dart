import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cube/cube/components/cube_face.dart';
import '../model/cube_rotation.dart';

enum Facing { top, bottom, left, right, front, back }

class CubeRotation {
  Rotate currentRotation = Rotate();
  List<Widget> cubes = [];

  CubeRotation() {
    updateCube();
  }

  Map<Facing, Widget> cube = {
    Facing.top: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, -30.0)
        ..rotateX(pi / 2),
      child: const CubeFace(
        color: Colors.white,
      ),
    ),
    Facing.bottom: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 90.0, -30.0)
        ..rotateX(pi / 2),
      child: const CubeFace(
        color: Colors.yellow,
      ),
    ),
    Facing.left: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, -30.0)
        ..rotateY(-pi / 2),
      child: const CubeFace(
        color: Colors.orange,
      ),
    ),
    Facing.right: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()
        ..translate(90.0, 0.0, -30.0)
        ..rotateY(-pi / 2),
      child: const CubeFace(
        color: Colors.red,
      ),
    ),
    Facing.front: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()..translate(0.0, 0.0, 60.0),
      child: const CubeFace(
        color: Colors.green,
      ),
    ),
    Facing.back: Transform(
      origin: const Offset(0, 0),
      transform: Matrix4.identity()..translate(0.0, 0.0, -30.0),
      child: const CubeFace(
        color: Colors.blue,
      ),
    ),
  };

  List<Widget> updateCube() {
    cubes = [];
    cubes.add(cube[Facing.bottom]!);
    cubes.add(cube[Facing.back]!);
    cubes.add(cube[Facing.left]!);
    cubes.add(cube[Facing.right]!);
    cubes.add(cube[Facing.top]!);
    cubes.add(cube[Facing.front]!);
    return cubes;
  }

  List<Widget> permutateCube({required Offset offset}) {
    Rotate rotate = _calculateRotation(offset: offset);
    if (currentRotation.U < rotate.U) {
      _rotateU();
    } else if (currentRotation.U > rotate.U) {
      _rotateU();
      _rotateU();
      _rotateU();
    }
    if (currentRotation.R > rotate.R) {
      _rotateR();
    } else if (currentRotation.R < rotate.R) {
      _rotateR();
      _rotateR();
      _rotateR();
    }
    currentRotation = rotate;
    return updateCube();
  }

  void _rotateR() {
    Widget temp = cube[Facing.front]!;
    cube[Facing.front] = cube[Facing.bottom]!;
    cube[Facing.bottom] = cube[Facing.back]!;
    cube[Facing.back] = cube[Facing.top]!;
    cube[Facing.top] = temp;
  }

  void _rotateU() {
    Widget temp = cube[Facing.left]!;
    cube[Facing.left] = cube[Facing.front]!;
    cube[Facing.front] = cube[Facing.right]!;
    cube[Facing.right] = cube[Facing.back]!;
    cube[Facing.back] = temp;
  }

  Rotate _calculateRotation({required Offset offset}) {
    Rotate rotate = Rotate();
    double dx = offset.dx;
    double dy = offset.dy;

    rotate.U = 0;
    while (dx < -90) {
      dx += 90;
      rotate.U++;
    }
    while (dx > 90) {
      dx -= 90;
      rotate.U--;
    }

    rotate.R = 0;
    while (dy < -90) {
      dy += 90;
      rotate.R++;
    }
    while (dy > 90) {
      dy -= 90;
      rotate.R--;
    }
    return rotate;
  }
}
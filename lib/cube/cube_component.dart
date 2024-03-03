import 'package:flutter/material.dart';
import 'dart:math';

enum Facing { top, bottom, left, right, front, back }

class CubeComponent extends StatelessWidget {
  final double cubeWidth = 40;
  Map<Facing, Widget> _cube = {};

  CubeComponent({super.key, isBlack = false}) {
    if (isBlack) {
      _cube = {
        Facing.top: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateX(pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.bottom: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, cubeWidth, -cubeWidth)
            ..rotateX(pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.left: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.right: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(cubeWidth, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.front: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.back: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, -cubeWidth),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
      };
    } else {
      _cube = {
        Facing.top: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateX(pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.bottom: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, cubeWidth, -cubeWidth)
            ..rotateX(pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.left: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.right: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()
            ..translate(cubeWidth, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.front: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
        Facing.back: Transform(
          origin: const Offset(0, 0),
          transform: Matrix4.identity()..translate(0.0, 0.0, -cubeWidth),
          child: Container(
            width: cubeWidth,
            height: cubeWidth,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
        ),
      };
    }
    _cubeFaces.add(_cube[Facing.back]!);
    _cubeFaces.add(_cube[Facing.bottom]!);
    _cubeFaces.add(_cube[Facing.left]!);
    _cubeFaces.add(_cube[Facing.right]!);
    _cubeFaces.add(_cube[Facing.top]!);
    _cubeFaces.add(_cube[Facing.front]!);
  }

  final List<Widget> _cubeFaces = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _cubeFaces,
    );
  }
}

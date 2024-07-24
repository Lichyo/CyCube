import 'package:flutter/material.dart';
import 'dart:math';
import 'cube_constants.dart';
import 'cube_state.dart';

class CubeComponent extends StatelessWidget {
  Map<Facing, Widget> cube = {};
  final Map<Facing, Color> cubeColor;
  List<Widget> cubeFaces = [];
  List<String> cubeFaceNames = [];

  CubeComponent({
    super.key,
    isBlack = false,
    required this.cubeColor,
  }) {
    cube = {
      Facing.top: Transform(
        origin: const Offset(0, 0),
        transform: Matrix4.identity()
          ..translate(0.0, 0.0, -cubeWidth)
          ..rotateX(pi / 2),
        child: Container(
          width: cubeWidth,
          height: cubeWidth,
          decoration: BoxDecoration(
            color: isBlack ? Colors.black : cubeColor[Facing.top],
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(3),
            ),
          ),
        ),
      ),
      Facing.down: Transform(
        origin: const Offset(0, 0),
        transform: Matrix4.identity()
          ..translate(0.0, cubeWidth, -cubeWidth)
          ..rotateX(pi / 2),
        child: Container(
          width: cubeWidth,
          height: cubeWidth,
          decoration: BoxDecoration(
            color: isBlack ? Colors.black : cubeColor[Facing.down],
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
            color: isBlack ? Colors.black : cubeColor[Facing.left],
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
            color: isBlack ? Colors.black : cubeColor[Facing.right],
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
            color: isBlack ? Colors.black : cubeColor[Facing.front],
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
            color: isBlack ? Colors.black : cubeColor[Facing.back],
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(3),
            ),
          ),
        ),
      ),
    };
    cubeFaces.add(cube[Facing.back]!);
    cubeFaces.add(cube[Facing.down]!);
    cubeFaces.add(cube[Facing.left]!);
    cubeFaces.add(cube[Facing.right]!);
    cubeFaces.add(cube[Facing.top]!);
    cubeFaces.add(cube[Facing.front]!);
    cubeFaceNames = [
      CubeState.transformColorToString(cubeColor[Facing.back]!),
      CubeState.transformColorToString(cubeColor[Facing.down]!),
      CubeState.transformColorToString(cubeColor[Facing.left]!),
      CubeState.transformColorToString(cubeColor[Facing.right]!),
      CubeState.transformColorToString(cubeColor[Facing.top]!),
      CubeState.transformColorToString(cubeColor[Facing.front]!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cubeFaces,
    );
  }
}
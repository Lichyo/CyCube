import 'package:flutter/material.dart';
import '../cube_constants.dart';
import 'package:cy_cube/components/cube_face.dart';
import 'dart:math';

class CubeComponent extends StatelessWidget {
  List<Widget>? cubeFaces;
  Map<Facing, Widget> cubeElements = {};
  Map<Facing, Color> cubeColor;

  CubeComponent({
    super.key,
    required this.cubeColor,
    this.cubeFaces,
  }) {
    if (cubeFaces == null) {
      print('use default cubeFaces');
      cubeFaces = [];
      cubeElements = {
        Facing.top: CubeFace(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateX(pi / 2),
          color: cubeColor[Facing.top]!,
        ),
        Facing.down: CubeFace(
          transform: Matrix4.identity()
            ..translate(0.0, cubeWidth, -cubeWidth)
            ..rotateX(pi / 2),
          color: cubeColor[Facing.down]!,
        ),
        Facing.left: CubeFace(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          color: cubeColor[Facing.left]!,
        ),
        Facing.right: CubeFace(
          transform: Matrix4.identity()
            ..translate(cubeWidth, 0.0, -cubeWidth)
            ..rotateY(-pi / 2),
          color: cubeColor[Facing.right]!,
        ),
        Facing.front: CubeFace(
          transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
          color: cubeColor[Facing.front]!,
        ),
        Facing.back: CubeFace(
          transform: Matrix4.identity()..translate(0.0, 0.0, -cubeWidth),
          color: cubeColor[Facing.back]!,
        ),
      };
      cubeFaces!.add(cubeElements[Facing.back]!);
      cubeFaces!.add(cubeElements[Facing.down]!);
      cubeFaces!.add(cubeElements[Facing.left]!);
      cubeFaces!.add(cubeElements[Facing.right]!);
      cubeFaces!.add(cubeElements[Facing.top]!);
      cubeFaces!.add(cubeElements[Facing.front]!);
    } else {
      print('use default cubeFaces');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cubeFaces!,
    );
  }
}

import 'dart:math';

import 'cube_component.dart';
import 'package:flutter/material.dart';

class Cube extends StatelessWidget {
  List<Widget> cube = [];

  Cube({super.key}) {
    final CubeComponent pieceCube = CubeComponent();
    final pieceCubeWidth = pieceCube.cubeWidth;

    cube.add(
      Transform(
        transform: Matrix4.identity(),
        child: CubeComponent(
          isBlack: true,
        ),
      ),
    );
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cube.add(
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  x * pieceCubeWidth, // 向右遞增
                  -y * pieceCubeWidth, // 向下遞增
                  z * pieceCubeWidth, // 向前遞增
                ),
              child: pieceCube,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cube,
    );
  }
}

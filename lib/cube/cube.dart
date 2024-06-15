import 'package:cube/cube/single_cube_model.dart';
import 'package:flutter/material.dart';
import 'cube_state.dart';

class Cube extends StatelessWidget {
  final List<Widget> _cube = [];
  final CubeState cubeState;

  Cube({super.key, required this.cubeState}) {
    for (SingleCubeModel cube in cubeState.cubeModels) {
      _cube.add(
        Transform(
          transform: Matrix4.identity()
            ..translate(
              cube.x, // 向右遞增
              cube.y, // 向下遞增
              cube.z, // 向前遞增
            ),
          child: cube.component,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _cube,
    );
  }
}

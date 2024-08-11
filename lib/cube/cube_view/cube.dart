import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:flutter/material.dart';
import '../cube_state.dart';

class Cube extends StatelessWidget {
  final List<Widget> _cube = [];

  Cube({super.key}) {
    for (int index in CubeState.indexWithStack) {
      final SingleCubeModel cube = CubeState.cubeModels[index];
      _cube.add(
        Transform(
          transform: Matrix4.identity()
            ..translate(
              cube.x,
              cube.y,
              cube.z,
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

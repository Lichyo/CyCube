import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';

class Cube extends StatelessWidget {
  final List<Widget> _cube;

  Cube({super.key}) : _cube = _buildCube();

  static List<Widget> _buildCube() {
    final List<Widget> cubeWidgets = [];
    for (int index in CubeState.indexWithStack) {
      final SingleCubeModel cube = CubeState.cubeModels[index];
      cubeWidgets.add(
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
    return cubeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (detail) {
        Provider.of<CubeState>(context, listen: false).listenToArrange(detail: detail);
      },
      child: Consumer<CubeState>(
        builder: (context, cubeState, child) {
          return AnimatedBuilder(
            animation: cubeState,
            builder: (context, child) {
              return Transform(
                origin: const Offset(0, 0),
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(cubeState.cubeDy * pi / 180)
                  ..rotateY(cubeState.cubeDx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: Stack(
                    children: _cube,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
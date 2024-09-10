import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cube_state.dart';
import '../cube_model/single_cube_model.dart';
import 'dart:math';


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
    return GestureDetector(
      onPanUpdate: (detail) {
        Provider.of<CubeState>(context, listen: false).listenToArrange(detail: detail);
      },
      child: Transform(
        origin: const Offset(0, 0),
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(Provider.of<CubeState>(context).cubeDy * pi / 180)
          ..rotateY(Provider.of<CubeState>(context).cubeDx * pi / 180)
          ..setEntry(2, 2, 0.001),
        child: Center(
          child: Stack(
            children: _cube,
          ),
        ),
      ),
    );
  }
}
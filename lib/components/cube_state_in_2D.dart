import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';

const double size = 65;

class CubeStateIn2D extends StatelessWidget {
  const CubeStateIn2D({
    super.key,
    required this.cubeState,
  });

  final CubeState cubeState;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: size,
                height: size,
              ),
              cubeState.show2DFace(facing: Facing.top),
              const SizedBox(
                width: size,
                height: size,
              ),
              const SizedBox(
                width: size,
                height: size,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              cubeState.show2DFace(facing: Facing.left),
              cubeState.show2DFace(facing: Facing.front),
              cubeState.show2DFace(facing: Facing.right),
              cubeState.show2DFace(facing: Facing.back),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: size,
                height: size,
              ),
              cubeState.show2DFace(facing: Facing.down),
              const SizedBox(
                width: size,
                height: size,
              ),
              const SizedBox(
                width: size,
                height: size,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

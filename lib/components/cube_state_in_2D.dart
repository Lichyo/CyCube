import 'package:cy_cube/components/single_cube_face.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';

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
        children: [
          Row(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
              ),
              cubeState.show2DFace(facing: Facing.top),
              const SizedBox(
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 60,
                height: 60,
              ),
            ],
          ),
          Row(
            children: [
              cubeState.show2DFace(facing: Facing.left),
              cubeState.show2DFace(facing: Facing.front),
              cubeState.show2DFace(facing: Facing.right),
              cubeState.show2DFace(facing: Facing.back),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
              ),
              cubeState.show2DFace(facing: Facing.down),
              const SizedBox(
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 60,
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

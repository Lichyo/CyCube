import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:provider/provider.dart';

const double size = 65;

class CubeStateIn2D extends StatelessWidget {
  const CubeStateIn2D({
    super.key,
  });


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
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.top),
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
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.left),
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.front),
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.right),
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.back),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: size,
                height: size,
              ),
              Provider.of<CubeState>(context, listen: false).show2DFace(facing: Facing.down),
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

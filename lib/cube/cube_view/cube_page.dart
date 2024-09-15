import 'package:cy_cube/components/cube_state_in_2D.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';

class CubePage extends StatelessWidget {
  const CubePage({
    super.key,
    required CubeState cubeState,
  }) : _cubeState = cubeState;

  final CubeState _cubeState;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MaxGap(200),
            Transform(
              origin: const Offset(0, 0),
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(Provider.of<CubeState>(context).cubeDy * pi / 180)
                ..rotateY(Provider.of<CubeState>(context).cubeDx * pi / 180)
                ..setEntry(2, 2, 0.001),
              child: Center(
                child: Cube(),
              ),
            ),
            const Gap(100),
            CubeRotationTable(
              onPressed: (rotation) {
                Provider.of<CubeState>(context, listen: false)
                    .rotate(rotation: rotation);
              },
            ),
            TextButton(
              onPressed: () async {
                // _roomID = await DatabaseService.createRoom(
                //   email: 'lichyo003@gmail.com',
                //   cubeState: _cubeState,
                // );
                // _isCreateRoom = true;
                // setState(() {});
              },
              child: const Text('create room'),
            ),
            const MaxGap(100),
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CubeStateIn2D(cubeState: _cubeState);
                  },
                );
                Provider.of<CubeState>(context, listen: false)
                    .show2DFace(facing: Facing.top);
              },
              child: Image.asset(
                'images/cube_icon.png',
                width: 80,
              ),
            ),
          ],
        );
      },
    );
  }
}

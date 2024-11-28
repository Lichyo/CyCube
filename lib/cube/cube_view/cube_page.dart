import 'package:cy_cube/components/cube_state_in_2D.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CubePage extends StatelessWidget {
  CubePage({
    super.key,
  });

  List<int> executionTimes = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        );
      },
    );
  }
}

import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:cy_cube/cube/cube_view/cube_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:cy_cube/components/cube_state_in_2D.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const MaxGap(200),
        CubePage(),
        const Gap(100),
        CubeRotationTable(
          onPressed: (rotation) {
            Provider.of<CubeState>(context, listen: false)
                .rotate(rotation: rotation);

          },
        ),
        const MaxGap(80),
        MaterialButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CubeStateIn2D();
              },
            );
            Provider.of<CubeState>(context, listen: false)
                .show2DFace(facing: Facing.top);
          },
          child: const FaIcon(
            FontAwesomeIcons.cube,
            size: 50,
          ),
        ),
      ],
    );
  }
}

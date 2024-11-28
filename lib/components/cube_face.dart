import 'package:flutter/material.dart';
import '../cube/cube_constants.dart';

class CubeFace extends StatelessWidget {
  const CubeFace({
    super.key,
    required this.transform,
    required this.color,
    required this.visible
  });

  final Matrix4 transform;
  final Color color;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Transform(
        origin: const Offset(0, 0),
        transform: transform,
        child: Container(
          width: cubeWidth,
          height: cubeWidth,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
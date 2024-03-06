import 'cube_component.dart';
import 'package:flutter/material.dart';

class SingleCubeModel {
  final double x;
  final double y;
  final double z;
  final int id;
  CubeComponent component;
  Map<Facing, Color> cubeColor;

  SingleCubeModel({
    required this.cubeColor,
    required this.id,
    required this.component,
    required this.x,
    required this.y,
    required this.z,
  });
}

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class CubeModel {
  int x;
  int y;
  int z;
  Color color;
  Vector vector;

  CubeModel({
    required this.x,
    required this.y,
    required this.z,
    required this.color,
    required this.vector,
  });
}

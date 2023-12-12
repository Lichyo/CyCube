import 'package:vector_math/vector_math.dart';
import 'package:flutter/material.dart';

class Face {
  Vector normal;
  Color color;

  Face({
    required this.color,
    required this.normal,
  });
}

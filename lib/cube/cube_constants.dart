import 'package:flutter/material.dart';

enum Facing { top, bottom, left, right, front, back }

final Map<Facing, Color> defaultCubeColor = {
  Facing.top: Colors.white,
  Facing.bottom: Colors.yellow,
  Facing.right: Colors.red,
  Facing.left: Colors.orange,
  Facing.front: Colors.green,
  Facing.back: Colors.blue,
};

const cubeWidth = 40.0;
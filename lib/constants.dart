import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum Facing { green, blue, red, orange, white, yellow }

Map<Facing, Widget?> cube = {
  Facing.green: null,
  Facing.blue: null,
  Facing.red: null,
  Facing.orange: null,
  Facing.white: null,
  Facing.yellow: null,
};

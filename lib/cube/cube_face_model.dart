import 'package:flutter/material.dart';

class CubeFaceModel {
  final int id;
  bool isSelected;
  Color? color;

  CubeFaceModel({
    required this.id,
    this.color = Colors.white,
    required this.isSelected,
  });
}

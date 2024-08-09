import 'package:flutter/material.dart';

class SingleCubeComponentFaceModel {
  final int id;
  bool isSelected;
  Color? color;

  SingleCubeComponentFaceModel({
    required this.id,
    this.color = Colors.white,
    this.isSelected = false,
  });
}

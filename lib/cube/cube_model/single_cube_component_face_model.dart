import 'package:flutter/material.dart';

class SingleCubeComponentFaceModel {
  int id;
  bool isSelected;
  Color? color;

  SingleCubeComponentFaceModel({
    required this.id,
    this.color = Colors.white,
    this.isSelected = false,
  });

  void reset({required int id, Color? color}) {
    this.id = id;
    this.color = color;
  }
}

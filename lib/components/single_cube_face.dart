import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_face_model.dart';

class SingleCubeFace extends StatelessWidget {
  const SingleCubeFace({
    super.key,
    required this.cubeFaceModel,
  });

  final CubeFaceModel cubeFaceModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: cubeFaceModel.color,
        border: Border.all(
          width: cubeFaceModel.isSelected ? 3 : 1,
          color: cubeFaceModel.isSelected ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}

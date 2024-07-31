import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';

class SingleCubeComponentFace extends StatelessWidget {
  const SingleCubeComponentFace({
    super.key,
    required this.cubeFaceModel,
    this.smaller = false,
  });

  final SingleCubeComponentFaceModel cubeFaceModel;
  final bool smaller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: smaller ? 20 : 80,
      height: smaller ? 20 : 80,
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

import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/components/single_cube_component_face.dart';

class SingleCubeFace extends StatelessWidget {
  const SingleCubeFace({
    super.key,
    required this.singleCubeComponentFaces,
  });

  final List<SingleCubeComponentFaceModel> singleCubeComponentFaces;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[6], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[7], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[8], smaller: true,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[3], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[4], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[5], smaller: true,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[0], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[1], smaller: true,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[2], smaller: true,),
          ],
        ),
      ],
    );
  }
}

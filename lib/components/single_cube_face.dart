import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/components/single_cube_component_face.dart';

class SingleCubeFace extends StatelessWidget {
  const SingleCubeFace({
    super.key,
    required this.singleCubeComponentFaces,
    this.smaller = false,
  });
  final bool smaller;
  final List<SingleCubeComponentFaceModel> singleCubeComponentFaces;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[6], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[7], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[8], smaller: smaller,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[3], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[4], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[5], smaller: smaller,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[0], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[1], smaller: smaller,),
            SingleCubeComponentFace(cubeFaceModel: singleCubeComponentFaces[2], smaller: smaller,),
          ],
        ),
      ],
    );
  }
}

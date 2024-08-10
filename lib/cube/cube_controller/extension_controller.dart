import 'package:cy_cube/components/single_cube_face.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';

class ExtensionController {
  static SingleCubeFace show2DFace({required Facing facing}) {
    List<SingleCubeComponentFaceModel> singleCubeComponentFaceModel = [];
    List<int> cubeFaceIndex = [];
    List<int> specificCubeFaceIndex = [6, 7, 8, 3, 4, 5, 0, 1, 2];  // from layer 0 to 2
    for (int index in specificCubeFaceIndex) {
      cubeFaceIndex.add(cubeFaceIDs[facing]![index]);
    }
    for (int index in cubeFaceIndex) {
      singleCubeComponentFaceModel.add(
        SingleCubeComponentFaceModel(
          id: index,
          color: CubeState.cubeModels[index].component.cubeColor[facing],
          isSelected: false,
        ),
      );
    }
    return SingleCubeFace(
      singleCubeComponentFaces: singleCubeComponentFaceModel,
      smaller: true,
    );
  }
}
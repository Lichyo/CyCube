import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_controller/tools.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';

class SetupController {
  List<String> generateCubeStatus() {
    List<String> cubeStatus = [];
    for (Facing cubeFace in cubeFaces) {
      for (int cubeFaceID in cubeFaceIDs[cubeFace]!) {
        String cubeColor = Tools.transformColorToString(
            CubeState.cubeModels[cubeFaceID].component.cubeColor[cubeFace]!);
        cubeStatus.add(cubeColor);
      }
    }
    return cubeStatus;
  }

  void setCubeStatus({required List<String> cubeStatus}) {
    int index = 0;
    for (Facing cubeFace in cubeFaces) {
      List<SingleCubeComponentFaceModel> cubeFaceModes = [];
      for (int cubeFaceID in cubeFaceIDs[cubeFace]!) {
        SingleCubeComponentFaceModel cubeFaceModel =
            SingleCubeComponentFaceModel(
          id: cubeFaceID,
          color: Tools.transformStringToColor(cubeStatus[index++]),
          isSelected: false,
        );
        cubeFaceModes.add(cubeFaceModel);
      }
      _setupSingleFace(
        cubeIDs: cubeFaceIDs[cubeFace]!,
        cubeFaces: cubeFaceModes,
        facing: cubeFace,
      );
    }
  }

  void setupCubeWithScanningColor(
      List<List<SingleCubeComponentFaceModel>> cubeFaces) {
    for (int i = 0; i < cubeFaces.length; i++) {
      if (cubeFaces[i][4].color == Colors.white) {
        _setupSingleFace(
          cubeIDs: [24, 25, 26, 15, 16, 17, 6, 7, 8],
          cubeFaces: cubeFaces[i],
          facing: Facing.top,
        );
      } else if (cubeFaces[i][4].color == Colors.yellow) {
        _setupSingleFace(
          cubeIDs: [0, 1, 2, 9, 10, 11, 18, 19, 20],
          cubeFaces: cubeFaces[i],
          facing: Facing.down,
        );
      } else if (cubeFaces[i][4].color == Colors.red) {
        _setupSingleFace(
          cubeIDs: [20, 11, 2, 23, 14, 5, 26, 17, 8],
          cubeFaces: cubeFaces[i],
          facing: Facing.right,
        );
      } else if (cubeFaces[i][4].color == Colors.orange) {
        _setupSingleFace(
          cubeIDs: [0, 9, 18, 3, 12, 21, 6, 15, 24],
          cubeFaces: cubeFaces[i],
          facing: Facing.left,
        );
      } else if (cubeFaces[i][4].color == Colors.blue) {
        _setupSingleFace(
          cubeIDs: [2, 1, 0, 5, 4, 3, 8, 7, 6],
          cubeFaces: cubeFaces[i],
          facing: Facing.back,
        );
      } else {
        _setupSingleFace(
          cubeIDs: [18, 19, 20, 21, 22, 23, 24, 25, 26],
          cubeFaces: cubeFaces[i],
          facing: Facing.front,
        );
      }
    }
  }

  void _setupSingleFace({
    required List<int> cubeIDs,
    required List<SingleCubeComponentFaceModel> cubeFaces,
    required Facing facing,
  }) {
    int i = 0;
    for (int id in cubeIDs) {
      Map<Facing, Color> updatedCubeColor =
          Map.from(CubeState.cubeModels[id].component.cubeColor);
      updatedCubeColor[facing] = cubeFaces[i].color!;
      CubeState.cubeModels[id] = SingleCubeModel(
        component: CubeComponent(
          cubeColor: updatedCubeColor,
        ),
        x: CubeState.cubeModels[id].x,
        y: CubeState.cubeModels[id].y,
        z: CubeState.cubeModels[id].z,
      );
      i++;
    }
  }
}

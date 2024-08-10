import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'package:flutter/material.dart';

class ArrangeController {
  static void arrangeCube({
    required String arrangeSide,
  }) {
    if (arrangeSide == 'right') {
      _arrangeCubeModel(arrangedSide: 'right');
      _arrangedSingleCubeFace([2, 1, 5, 0, 4, 3]);
    } else if (arrangeSide == 'left') {
      _arrangeCubeModel(arrangedSide: 'left');
      _arrangedSingleCubeFace([3, 1, 0, 5, 4, 2]);
    } else if (arrangeSide == 'up') {
      _arrangeCubeModel(arrangedSide: 'up');
      _arrangedSingleCubeFace([4, 0, 2, 3, 5, 1]);
    } else if (arrangeSide == 'down') {
      _arrangeCubeModel(arrangedSide: 'down');
      _arrangedSingleCubeFace([1, 5, 2, 3, 0, 4]);
    }
  }

  static void _arrangeCubeModel({
    required String arrangedSide,
  }) {
    List<int> list = [];
    if (arrangedSide == 'right') {
      for (int index in cubeArrangeX) {
        list.add(CubeState.indexWithStack[index]);
      }
    } else if (arrangedSide == 'left') {
      for (int index in cubeArrangeXReverse) {
        list.add(CubeState.indexWithStack[index]);
      }
    } else if (arrangedSide == 'up') {
      for (int index in cubeArrangeY) {
        list.add(CubeState.indexWithStack[index]);
      }
    } else if (arrangedSide == 'down') {
      for (int index in cubeArrangeYReverse) {
        list.add(CubeState.indexWithStack[index]);
      }
    } else {}
    CubeState.indexWithStack = list;
  }

  static void _arrangedSingleCubeFace(List<int> cubeFaceIndex) {
    for (SingleCubeModel cubeModel in CubeState.cubeModels) {
      List<Widget> arrangedCubeFaces = [];
      List<int> arrangedCubeFaceIndex = [];
      for (int index in cubeFaceIndex) {
        arrangedCubeFaces.add(cubeModel.component.cubeFaces![index]);
        arrangedCubeFaceIndex.add(cubeModel.component.cubeFaceIndex![index]);
      }
      cubeModel.component = CubeComponent(
        cubeColor: cubeModel.component.cubeColor,
        cubeFaces: arrangedCubeFaces,
        cubeFaceIndex: arrangedCubeFaceIndex,
      );
    }
  }
}

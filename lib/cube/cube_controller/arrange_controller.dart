import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrangeController {
  static bool isArrangedRight = false;
  static bool isArrangedLeft = false;
  static int arrangeCountX = 0;
  static int arrangeCountY = 0;
  static double dy = 0;
  static double dx = 0;
  static Offset offset = Offset.zero;

  void listenToArrange({
    required DragUpdateDetails detail,
  }) {
    offset += detail.delta;

    if (arrangeCountY == 0) {
      dx = offset.dx;
    }

    if (offset.dy < 50 && offset.dy > -50) {
      dy += detail.delta.dy;
    }

    if ((dx / 90).floor() < arrangeCountX - 1 && arrangeCountY == 0) {
      arrangeCountX--;
      _arrangeCube(arrangeSide: 'right');
    } else if ((dx / 90).floor() > arrangeCountX - 1 && arrangeCountY == 0) {
      arrangeCountX++;
      _arrangeCube(arrangeSide: 'left');
    } else if (arrangeCountY != 0) {
      // Forbidden to Move
    }

    if ((offset.dy / 90).floor() + 1 > 0 && arrangeCountY == 0) {
      arrangeCountY++;
      _arrangeCube(arrangeSide: 'up');
    } else if ((offset.dy / 90).floor() + 1 == 0 && arrangeCountY == 1) {
      arrangeCountY--;
      _arrangeCube(arrangeSide: 'down');
    }
  }

  void _arrangeCube({
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

  void _arrangeCubeModel({
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

  void _arrangedSingleCubeFace(List<int> cubeFaceIndex) {
    for (SingleCubeModel cubeModel in CubeState.cubeModels) {
      List<Widget> arrangedCubeFaces = [];
      List<int> arrangedCubeFaceIndex = [];
      for (int index in cubeFaceIndex) {
        arrangedCubeFaces.add(cubeModel.component.cubeFaces![index]);
        arrangedCubeFaceIndex.add(cubeModel.component.cubeFaceIndex![index]);
      }
      cubeModel.component = CubeComponent(
        visibleControl: cubeModel.component.visibleControl,
        cubeColor: cubeModel.component.cubeColor,
        cubeFaces: arrangedCubeFaces,
        cubeFaceIndex: arrangedCubeFaceIndex,
      );
    }
  }
}

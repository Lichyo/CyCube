import 'package:cube/cube/cube.dart';
import 'package:cube/cube/cube_component.dart';
import 'single_cube_model.dart';
import 'package:flutter/material.dart';

class CubeState {
  List<SingleCubeModel> cubeModels = [];
  final double width;
  Map<Facing, Color> cubeColor = {
    Facing.top: Colors.white,
    Facing.bottom: Colors.yellow,
    Facing.right: Colors.red,
    Facing.left: Colors.orange,
    Facing.front: Colors.green,
    Facing.back: Colors.blue,
  };

  void updateCubeComponent({
    required int id,
  }) {
    final updatedCubeColor = _updateXColor(cube: cubeModels[id]);
    cubeModels[id] = SingleCubeModel(
      cubeColor: updatedCubeColor,
      id: id,
      component: CubeComponent(
        cubeWidth: width,
        cubeColor: updatedCubeColor,
      ),
      x: cubeModels[id].x,
      y: cubeModels[id].y,
      z: cubeModels[id].z,
    );
  }

  CubeState({required this.width}) {
    int id = 0;
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cubeModels.add(
            SingleCubeModel(
              id: id,
              cubeColor: cubeColor,
              component: CubeComponent(
                cubeColor: cubeColor,
                cubeWidth: width,
              ),
              x: x * width,
              y: -y * width,
              z: z * width,
            ),
          );
          id++;
        }
      }
    }
  }

  void _shift(List<int> cornerIds, List<int> edgeIds) {
    final CubeComponent cornerComponent = cubeModels[cornerIds[0]].component;
    cubeModels[cornerIds[0]].component = cubeModels[cornerIds[1]].component;
    cubeModels[cornerIds[1]].component = cubeModels[cornerIds[2]].component;
    cubeModels[cornerIds[2]].component = cubeModels[cornerIds[3]].component;
    cubeModels[cornerIds[3]].component = cornerComponent;

    final CubeComponent edgeComponent = cubeModels[edgeIds[0]].component;
    cubeModels[edgeIds[0]].component = cubeModels[edgeIds[1]].component;
    cubeModels[edgeIds[1]].component = cubeModels[edgeIds[2]].component;
    cubeModels[edgeIds[2]].component = cubeModels[edgeIds[3]].component;
    cubeModels[edgeIds[3]].component = edgeComponent;
  }

  void rMove() {
    _shift([26, 20, 2, 8], [5, 17, 23, 11]);
  }

  void rMoveReverse() {
    _shift([8, 2, 20, 26], [11, 23, 17, 5]);
  }

  void lMove() {
    _shift([6, 0, 18, 24], [9, 3, 15, 21]);
  }

  void lMoveReverse() {
    _shift([24, 18, 0, 6], [21, 15, 3, 9]);
  }

  void fMove() {
    _shift([20, 26, 24, 18], [19, 23, 25, 21]);
  }

  void fMoveReverse() {
    _shift([18, 24, 26, 20], [21, 25, 23, 19]);
  }

  void bMove() {
    _shift([6, 8, 2, 0], [5, 7, 3, 1]);
  }

  void bMoveReverse() {
    _shift([0, 2, 8, 6], [1, 3, 7, 5]);
  }

  void uMove() {
    _shift([8, 6, 24, 26], [17, 7, 15, 25]);
  }

  void uMoveReverse() {
    _shift([26, 24, 6, 8], [25, 15, 7, 17]);
  }

  void dMove() {
    _shift([2, 20, 18, 0], [11, 1, 9, 19]);
  }

  void dMoveReverse() {
    _shift([0, 18, 20, 2], [19, 9, 1, 11]);
  }

  Map<Facing, Color> _updateXColor({required SingleCubeModel cube}) {
    Color topColor = cube.component.cubeColor[Facing.top]!;
    cube.component.cubeColor[Facing.top] =
        cube.component.cubeColor[Facing.front]!;
    cube.component.cubeColor[Facing.front] =
        cube.component.cubeColor[Facing.bottom]!;
    cube.component.cubeColor[Facing.bottom] =
        cube.component.cubeColor[Facing.back]!;
    cube.component.cubeColor[Facing.back] = topColor;
    return cube.cubeColor;
  }
}

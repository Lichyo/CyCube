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

  // 2, 5, 8
  // 11, 14, 17
  // 20, 23, 26

  // 26 -> 8
  // 8 -> 2
  // 2 -> 20
  // 20 -> 26
  // void rMove() {
  //   updateCubeComponent(id: 2);
  //   // updateCubeComponent(id: 5);
  //   updateCubeComponent(id: 8);
  //   // updateCubeComponent(id: 11);
  //   // updateCubeComponent(id: 17);
  //   updateCubeComponent(id: 20);
  //   updateCubeComponent(id: 26);
  //   // updateCubeComponent(id: 23);
  // }

  void rMove() {
    final CubeComponent cornerComponent = cubeModels[26].component;
    cubeModels[26].component = cubeModels[20].component;
    cubeModels[20].component = cubeModels[2].component;
    cubeModels[2].component = cubeModels[8].component;
    cubeModels[8].component = cornerComponent;

    final CubeComponent edgeComponent = cubeModels[5].component;
    cubeModels[5].component = cubeModels[17].component;
    cubeModels[17].component = cubeModels[23].component;
    cubeModels[23].component = cubeModels[11].component;
    cubeModels[11].component = edgeComponent;
  }

  void bMoveReverse() {
    final CubeComponent cornerComponent = cubeModels[0].component;
    cubeModels[0].component = cubeModels[2].component;
    cubeModels[2].component = cubeModels[8].component;
    cubeModels[8].component = cubeModels[6].component;
    cubeModels[6].component = cornerComponent;

    final CubeComponent edgeComponent = cubeModels[1].component;
    cubeModels[1].component = cubeModels[3].component;
    cubeModels[3].component = cubeModels[7].component;
    cubeModels[7].component = cubeModels[5].component;
    cubeModels[5].component = edgeComponent;
  }

  void uMove() {
    final CubeComponent cornerComponent = cubeModels[8].component;
    cubeModels[8].component = cubeModels[6].component;
    cubeModels[6].component = cubeModels[24].component;
    cubeModels[24].component = cubeModels[26].component;
    cubeModels[26].component = cornerComponent;

    final CubeComponent edgeComponent = cubeModels[17].component;
    cubeModels[17].component = cubeModels[7].component;
    cubeModels[7].component = cubeModels[15].component;
    cubeModels[15].component = cubeModels[25].component;
    cubeModels[25].component = edgeComponent;
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

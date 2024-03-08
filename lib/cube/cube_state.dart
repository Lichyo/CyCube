import 'package:cube/cube/cube.dart';
import 'package:cube/cube/cube_component.dart';
import 'single_cube_model.dart';
import 'package:flutter/material.dart';

class CubeState {
  List<SingleCubeModel> cubeModels = [];
  final double width;
  final Map<Facing, Color> defaultCubeColor = {
    Facing.top: Colors.white,
    Facing.bottom: Colors.yellow,
    Facing.right: Colors.red,
    Facing.left: Colors.orange,
    Facing.front: Colors.green,
    Facing.back: Colors.blue,
  };

  String printColor(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.orange) {
      return 'orange';
    } else if (color == Colors.white) {
      return 'white';
    } else if (color == Colors.yellow) {
      return 'yellow';
    } else if (color == Colors.blue) {
      return 'blue';
    } else if (color == Colors.black) {
      return 'black';
    } else {
      return 'green';
    }
  }

  void searchUpdate(List<int> ids) {
    for (int id in ids) {
      print(
          '$id : top : ${printColor(cubeModels[id].component.cubeColor[Facing.top]!)}');
      print(
          '$id : bottom : ${printColor(cubeModels[id].component.cubeColor[Facing.bottom]!)}');
      print(
          '$id : right : ${printColor(cubeModels[id].component.cubeColor[Facing.right]!)}');
      print(
          '$id : left : ${printColor(cubeModels[id].component.cubeColor[Facing.left]!)}');
      print(
          '$id : front : ${printColor(cubeModels[id].component.cubeColor[Facing.front]!)}');
      print(
          '$id : back : ${printColor(cubeModels[id].component.cubeColor[Facing.back]!)}');
      print('\n');
    }
  }

  void _updateCubeComponent({
    required List<int> ids,
    required String axis,
  }) {
    for (int id in ids) {
      Map<Facing, Color> updatedCubeColor = {};
      if (axis == 'x') {
        updatedCubeColor = _updateXColor(cube: cubeModels[id]);
      } else if (axis == 'xx') {
        updatedCubeColor = _updateXColorReverse(cube: cubeModels[id]);
      } else if (axis == 'y') {
        updatedCubeColor = _updateYColor(cube: cubeModels[id]);
      } else if (axis == 'yy') {
        updatedCubeColor = _updateYColorReverse(cube: cubeModels[id]);
      } else if (axis == 'z') {
        updatedCubeColor = _updateZColor(cube: cubeModels[id]);
      } else {
        updatedCubeColor = _updateZColorReverse(cube: cubeModels[id]);
      }
      cubeModels[id] = SingleCubeModel(
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
  }

  CubeState({required this.width}) {
    int id = 0;
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cubeModels.add(
            SingleCubeModel(
              id: id,
              component: CubeComponent(
                cubeColor: Map.from(defaultCubeColor),
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
    _updateCubeComponent(ids: [26, 20, 2, 8, 5, 17, 23, 11], axis: 'x');
    _shift([26, 20, 2, 8], [5, 17, 23, 11]);
  }

  void rMoveReverse() {
    _updateCubeComponent(ids: [8, 2, 20, 26, 11, 23, 17, 5], axis: 'xx');
    _shift([8, 2, 20, 26], [11, 23, 17, 5]);
  }

  void lMove() {
    _updateCubeComponent(ids: [6, 0, 18, 24, 15, 3, 9, 21], axis: 'xx');
    _shift([6, 0, 18, 24], [15, 3, 9, 21]);
  }

  void lMoveReverse() {
    _updateCubeComponent(ids: [24, 18, 0, 6, 21, 15, 3, 9], axis: 'x');
    _shift([24, 18, 0, 6], [21, 9, 3, 15]);
  }

  void fMove() {
    _updateCubeComponent(ids: [20, 26, 24, 18, 19, 23, 25, 21], axis: 'y');
    _shift([20, 26, 24, 18], [19, 23, 25, 21]);
  }

  void fMoveReverse() {
    _updateCubeComponent(ids: [18, 24, 26, 20, 21, 25, 23, 19], axis: 'yy');
    _shift([18, 24, 26, 20], [21, 25, 23, 19]);
  }

  void bMove() {
    _updateCubeComponent(ids: [6, 8, 2, 0, 5, 7, 3, 1], axis: 'yy');
    _shift([6, 8, 2, 0], [7, 5, 1, 3]);
  }

  void bMoveReverse() {
    _updateCubeComponent(ids: [0, 2, 8, 6, 1, 3, 7, 5], axis: 'y');
    _shift([0, 2, 8, 6], [3, 1, 5, 7]);
  }

  void uMove() {
    _updateCubeComponent(ids: [8, 6, 24, 26, 17, 7, 15, 25], axis: 'z');
    _shift([8, 6, 24, 26], [17, 7, 15, 25]);
  }

  void uMoveReverse() {
    _updateCubeComponent(ids: [26, 24, 6, 8, 25, 15, 7, 17], axis: 'zz');
    _shift([26, 24, 6, 8], [25, 15, 7, 17]);
  }

  void dMove() {
    _updateCubeComponent(ids: [2, 20, 18, 0, 11, 1, 9, 19], axis: 'zz');
    _shift([2, 20, 18, 0], [1, 11, 19, 9]);
  }

  void dMoveReverse() {
    _updateCubeComponent(ids: [0, 18, 20, 2, 19, 9, 1, 11], axis: 'z');
    _shift([0, 18, 20, 2], [9, 19, 11, 1]);
  }

  Map<Facing, Color> _updateXColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color topColor = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.bottom]!;
    cubeColor[Facing.bottom] = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = topColor;
    return cubeColor;
  }

  Map<Facing, Color> _updateXColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = cubeColor[Facing.bottom]!;
    cubeColor[Facing.bottom] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateYColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.bottom]!;
    cubeColor[Facing.bottom] = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateYColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = cubeColor[Facing.bottom]!;
    cubeColor[Facing.bottom] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateZColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = color;
    return cubeColor;
  }

  Map<Facing, Color> _updateZColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = color;
    return cubeColor;
  }
}

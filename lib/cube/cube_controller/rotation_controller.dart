import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_constants.dart';

class RotationController {
  void rotate({required String rotation}) {
    if (rotation == 'U') {
      _uMove();
    } else if (rotation == 'U\'') {
      _uMoveReverse();
    } else if (rotation == 'D') {
      _dMove();
    } else if (rotation == 'D\'') {
      _dMoveReverse();
    } else if (rotation == 'R') {
      _rMove();
    } else if (rotation == 'R\'') {
      _rMoveReverse();
    } else if (rotation == 'L') {
      _lMove();
    } else if (rotation == 'L\'') {
      _lMoveReverse();
    } else if (rotation == 'F') {
      _fMove();
    } else if (rotation == 'F\'') {
      _fMoveReverse();
    } else if (rotation == 'B') {
      _bMove();
    } else if (rotation == 'B\'') {
      _bMoveReverse();
    } else {}
  }

  void _rMove() {
    _updateCubeComponent(ids: [26, 20, 2, 8, 5, 17, 23, 11], axis: 'x');
    _shift([26, 20, 2, 8], [5, 17, 23, 11]);
  }

  void _rMoveReverse() {
    _updateCubeComponent(ids: [8, 2, 20, 26, 11, 23, 17, 5], axis: 'xx');
    _shift([8, 2, 20, 26], [11, 23, 17, 5]);
  }

  void _lMove() {
    _updateCubeComponent(ids: [6, 0, 18, 24, 15, 3, 9, 21], axis: 'xx');
    _shift([6, 0, 18, 24], [15, 3, 9, 21]);
  }

  void _lMoveReverse() {
    _updateCubeComponent(ids: [24, 18, 0, 6, 21, 15, 3, 9], axis: 'x');
    _shift([24, 18, 0, 6], [21, 9, 3, 15]);
  }

  void _fMove() {
    _updateCubeComponent(ids: [20, 26, 24, 18, 19, 23, 25, 21], axis: 'y');
    _shift([20, 26, 24, 18], [19, 23, 25, 21]);
  }

  void _fMoveReverse() {
    _updateCubeComponent(ids: [18, 24, 26, 20, 21, 25, 23, 19], axis: 'yy');
    _shift([18, 24, 26, 20], [21, 25, 23, 19]);
  }

  void _bMove() {
    _updateCubeComponent(ids: [6, 8, 2, 0, 5, 7, 3, 1], axis: 'yy');
    _shift([6, 8, 2, 0], [7, 5, 1, 3]);
  }

  void _bMoveReverse() {
    _updateCubeComponent(ids: [0, 2, 8, 6, 1, 3, 7, 5], axis: 'y');
    _shift([0, 2, 8, 6], [3, 1, 5, 7]);
  }

  void _uMove() {
    _updateCubeComponent(ids: [8, 6, 24, 26, 17, 7, 15, 25], axis: 'z');
    _shift([8, 6, 24, 26], [17, 7, 15, 25]);
  }

  void _uMoveReverse() {
    _updateCubeComponent(ids: [26, 24, 6, 8, 25, 15, 7, 17], axis: 'zz');
    _shift([26, 24, 6, 8], [25, 15, 7, 17]);
  }

  void _dMove() {
    _updateCubeComponent(ids: [2, 20, 18, 0, 11, 1, 9, 19], axis: 'zz');
    _shift([2, 20, 18, 0], [1, 11, 19, 9]);
  }

  void _dMoveReverse() {
    _updateCubeComponent(ids: [0, 18, 20, 2, 19, 9, 1, 11], axis: 'z');
    _shift([0, 18, 20, 2], [9, 19, 11, 1]);
  }

  Map<Facing, Color> _updateXColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color topColor = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = topColor;

    return cubeColor;
  }

  Map<Facing, bool> _updateXVisibility({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool topVisible = visibleControl[Facing.top]!;
    visibleControl[Facing.top] = visibleControl[Facing.front]!;
    visibleControl[Facing.front] = visibleControl[Facing.down]!;
    visibleControl[Facing.down] = visibleControl[Facing.back]!;
    visibleControl[Facing.back] = topVisible;
    return visibleControl;
  }

  Map<Facing, Color> _updateXColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.back]!;
    cubeColor[Facing.back] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.front]!;
    cubeColor[Facing.front] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, bool> _updateXVisibilityReverse({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool topVisible = visibleControl[Facing.top]!;
    visibleControl[Facing.top] = visibleControl[Facing.back]!;
    visibleControl[Facing.back] = visibleControl[Facing.down]!;
    visibleControl[Facing.down] = visibleControl[Facing.front]!;
    visibleControl[Facing.front] = topVisible;
    return visibleControl;
  }

  Map<Facing, Color> _updateYColorReverse({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = color;
    return cubeColor;
  }

  Map<Facing, bool> _updateYVisibilityReverse({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool topVisible = visibleControl[Facing.top]!;
    visibleControl[Facing.top] = visibleControl[Facing.right]!;
    visibleControl[Facing.right] = visibleControl[Facing.down]!;
    visibleControl[Facing.down] = visibleControl[Facing.left]!;
    visibleControl[Facing.left] = topVisible;
    return visibleControl;
  }

  Map<Facing, Color> _updateYColor({required SingleCubeModel cube}) {
    Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
    final Color color = cubeColor[Facing.left]!;
    cubeColor[Facing.left] = cubeColor[Facing.down]!;
    cubeColor[Facing.down] = cubeColor[Facing.right]!;
    cubeColor[Facing.right] = cubeColor[Facing.top]!;
    cubeColor[Facing.top] = color;
    return cubeColor;
  }

  Map<Facing, bool> _updateYVisibility({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool topVisible = visibleControl[Facing.top]!;
    visibleControl[Facing.top] = visibleControl[Facing.left]!;
    visibleControl[Facing.left] = visibleControl[Facing.down]!;
    visibleControl[Facing.down] = visibleControl[Facing.right]!;
    visibleControl[Facing.right] = topVisible;
    return visibleControl;
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

  Map<Facing, bool> _updateZVisibility({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool leftVisible = visibleControl[Facing.left]!;
    visibleControl[Facing.left] = visibleControl[Facing.front]!;
    visibleControl[Facing.front] = visibleControl[Facing.right]!;
    visibleControl[Facing.right] = visibleControl[Facing.back]!;
    visibleControl[Facing.back] = leftVisible;
    return visibleControl;
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

  Map<Facing, bool> _updateZVisibilityReverse({required SingleCubeModel cube}) {
    Map<Facing, bool> visibleControl = Map.from(cube.component.visibleControl);
    final bool leftVisible = visibleControl[Facing.left]!;
    visibleControl[Facing.left] = visibleControl[Facing.back]!;
    visibleControl[Facing.back] = visibleControl[Facing.right]!;
    visibleControl[Facing.right] = visibleControl[Facing.front]!;
    visibleControl[Facing.front] = leftVisible;
    return visibleControl;
  }

  void _shift(List<int> cornerIds, List<int> edgeIds) {
    final CubeComponent cornerComponent =
        CubeState.cubeModels[cornerIds[0]].component;
    CubeState.cubeModels[cornerIds[0]].component =
        CubeState.cubeModels[cornerIds[1]].component;
    CubeState.cubeModels[cornerIds[1]].component =
        CubeState.cubeModels[cornerIds[2]].component;
    CubeState.cubeModels[cornerIds[2]].component =
        CubeState.cubeModels[cornerIds[3]].component;
    CubeState.cubeModels[cornerIds[3]].component = cornerComponent;

    final CubeComponent edgeComponent =
        CubeState.cubeModels[edgeIds[0]].component;
    CubeState.cubeModels[edgeIds[0]].component =
        CubeState.cubeModels[edgeIds[1]].component;
    CubeState.cubeModels[edgeIds[1]].component =
        CubeState.cubeModels[edgeIds[2]].component;
    CubeState.cubeModels[edgeIds[2]].component =
        CubeState.cubeModels[edgeIds[3]].component;
    CubeState.cubeModels[edgeIds[3]].component = edgeComponent;
  }

  void _updateCubeComponent({
    required List<int> ids,
    required String axis,
  }) {
    for (int id in ids) {
      Map<Facing, Color> updatedCubeColor = {};
      Map<Facing, bool> updatedVisibleControl = {};
      if (axis == 'x') {
        updatedCubeColor = _updateXColor(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateXVisibility(cube: CubeState.cubeModels[id]);
      } else if (axis == 'xx') {
        updatedCubeColor = _updateXColorReverse(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateXVisibilityReverse(cube: CubeState.cubeModels[id]);
      } else if (axis == 'y') {
        updatedCubeColor = _updateYColor(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateYVisibility(cube: CubeState.cubeModels[id]);
      } else if (axis == 'yy') {
        updatedCubeColor = _updateYColorReverse(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateYVisibilityReverse(cube: CubeState.cubeModels[id]);
      } else if (axis == 'z') {
        updatedCubeColor = _updateZColor(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateZVisibility(cube: CubeState.cubeModels[id]);
      } else {
        updatedCubeColor = _updateZColorReverse(cube: CubeState.cubeModels[id]);
        updatedVisibleControl = _updateZVisibilityReverse(cube: CubeState.cubeModels[id]);
      }
      CubeState.cubeModels[id] = SingleCubeModel(
        component: CubeComponent(
          visibleControl: updatedVisibleControl,
          cubeColor: updatedCubeColor,
          cubeFaceIndex: CubeState.cubeModels[id].component.cubeFaceIndex,
        ),
        x: CubeState.cubeModels[id].x,
        y: CubeState.cubeModels[id].y,
        z: CubeState.cubeModels[id].z,
      );
    }
  }
}

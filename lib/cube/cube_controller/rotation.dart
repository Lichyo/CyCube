// import 'package:cy_cube/cube/cube_constants.dart';
//
// class Rotation {
//   void rotate(String rotation) {
//     if (rotation == 'U') {
//       uMove();
//     } else if (rotation == 'U\'') {
//       uMoveReverse();
//     } else if (rotation == 'D') {
//       dMove();
//     } else if (rotation == 'D\'') {
//       dMoveReverse();
//     } else if (rotation == 'R') {
//       rMove();
//     } else if (rotation == 'R\'') {
//       rMoveReverse();
//     } else if (rotation == 'L') {
//       lMove();
//     } else if (rotation == 'L\'') {
//       lMoveReverse();
//     } else if (rotation == 'F') {
//       fMove();
//     } else if (rotation == 'F\'') {
//       fMoveReverse();
//     } else if (rotation == 'B') {
//       bMove();
//     } else if (rotation == 'B\'') {
//       bMoveReverse();
//     } else if (rotation == '') {}
//     if (onStateChange != null) {
//       onStateChange!();
//     }
//   }
//
//   void rMove() {
//     _updateCubeComponent(ids: [26, 20, 2, 8, 5, 17, 23, 11], axis: 'x');
//     _shift([26, 20, 2, 8], [5, 17, 23, 11]);
//   }
//
//   void rMoveReverse() {
//     _updateCubeComponent(ids: [8, 2, 20, 26, 11, 23, 17, 5], axis: 'xx');
//     _shift([8, 2, 20, 26], [11, 23, 17, 5]);
//   }
//
//   void lMove() {
//     _updateCubeComponent(ids: [6, 0, 18, 24, 15, 3, 9, 21], axis: 'xx');
//     _shift([6, 0, 18, 24], [15, 3, 9, 21]);
//   }
//
//   void lMoveReverse() {
//     _updateCubeComponent(ids: [24, 18, 0, 6, 21, 15, 3, 9], axis: 'x');
//     _shift([24, 18, 0, 6], [21, 9, 3, 15]);
//   }
//
//   void fMove() {
//     _updateCubeComponent(ids: [20, 26, 24, 18, 19, 23, 25, 21], axis: 'y');
//     _shift([20, 26, 24, 18], [19, 23, 25, 21]);
//   }
//
//   void fMoveReverse() {
//     _updateCubeComponent(ids: [18, 24, 26, 20, 21, 25, 23, 19], axis: 'yy');
//     _shift([18, 24, 26, 20], [21, 25, 23, 19]);
//   }
//
//   void bMove() {
//     _updateCubeComponent(ids: [6, 8, 2, 0, 5, 7, 3, 1], axis: 'yy');
//     _shift([6, 8, 2, 0], [7, 5, 1, 3]);
//   }
//
//   void bMoveReverse() {
//     _updateCubeComponent(ids: [0, 2, 8, 6, 1, 3, 7, 5], axis: 'y');
//     _shift([0, 2, 8, 6], [3, 1, 5, 7]);
//   }
//
//   void uMove() {
//     _updateCubeComponent(ids: [8, 6, 24, 26, 17, 7, 15, 25], axis: 'z');
//     _shift([8, 6, 24, 26], [17, 7, 15, 25]);
//   }
//
//   void uMoveReverse() {
//     _updateCubeComponent(ids: [26, 24, 6, 8, 25, 15, 7, 17], axis: 'zz');
//     _shift([26, 24, 6, 8], [25, 15, 7, 17]);
//   }
//
//   void dMove() {
//     _updateCubeComponent(ids: [2, 20, 18, 0, 11, 1, 9, 19], axis: 'zz');
//     _shift([2, 20, 18, 0], [1, 11, 19, 9]);
//   }
//
//   void dMoveReverse() {
//     _updateCubeComponent(ids: [0, 18, 20, 2, 19, 9, 1, 11], axis: 'z');
//     _shift([0, 18, 20, 2], [9, 19, 11, 1]);
//   }
//
//   Map<Facing, Color> _updateXColor({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color topColor = cubeColor[Facing.top]!;
//     cubeColor[Facing.top] = cubeColor[Facing.front]!;
//     cubeColor[Facing.front] = cubeColor[Facing.down]!;
//     cubeColor[Facing.down] = cubeColor[Facing.back]!;
//     cubeColor[Facing.back] = topColor;
//     return cubeColor;
//   }
//
//   Map<Facing, Color> _updateXColorReverse({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color color = cubeColor[Facing.back]!;
//     cubeColor[Facing.back] = cubeColor[Facing.down]!;
//     cubeColor[Facing.down] = cubeColor[Facing.front]!;
//     cubeColor[Facing.front] = cubeColor[Facing.top]!;
//     cubeColor[Facing.top] = color;
//     return cubeColor;
//   }
//
//   Map<Facing, Color> _updateYColorReverse({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color color = cubeColor[Facing.top]!;
//     cubeColor[Facing.top] = cubeColor[Facing.right]!;
//     cubeColor[Facing.right] = cubeColor[Facing.down]!;
//     cubeColor[Facing.down] = cubeColor[Facing.left]!;
//     cubeColor[Facing.left] = color;
//     return cubeColor;
//   }
//
//   Map<Facing, Color> _updateYColor({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color color = cubeColor[Facing.left]!;
//     cubeColor[Facing.left] = cubeColor[Facing.down]!;
//     cubeColor[Facing.down] = cubeColor[Facing.right]!;
//     cubeColor[Facing.right] = cubeColor[Facing.top]!;
//     cubeColor[Facing.top] = color;
//     return cubeColor;
//   }
//
//   Map<Facing, Color> _updateZColor({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color color = cubeColor[Facing.left]!;
//     cubeColor[Facing.left] = cubeColor[Facing.front]!;
//     cubeColor[Facing.front] = cubeColor[Facing.right]!;
//     cubeColor[Facing.right] = cubeColor[Facing.back]!;
//     cubeColor[Facing.back] = color;
//     return cubeColor;
//   }
//
//   Map<Facing, Color> _updateZColorReverse({required SingleCubeModel cube}) {
//     Map<Facing, Color> cubeColor = Map.from(cube.component.cubeColor);
//     final Color color = cubeColor[Facing.back]!;
//     cubeColor[Facing.back] = cubeColor[Facing.right]!;
//     cubeColor[Facing.right] = cubeColor[Facing.front]!;
//     cubeColor[Facing.front] = cubeColor[Facing.left]!;
//     cubeColor[Facing.left] = color;
//     return cubeColor;
//   }
// }

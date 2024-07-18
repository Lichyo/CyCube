import 'package:flutter/material.dart';

enum Facing { top, down, left, right, front, back }

const Map<Facing, Color> defaultCubeColor = {
  Facing.top: Colors.white,
  Facing.down: Colors.yellow,
  Facing.right: Colors.red,
  Facing.left: Colors.orange,
  Facing.front: Colors.green,
  Facing.back: Colors.blue,
};

const cubeWidth = 40.0;

const Map<Facing, List<int>> cubeFaceIDs = {
  Facing.top: [6, 7, 8, 15, 16, 17, 24, 25, 26],
  Facing.down: [18, 19, 20, 9, 10, 11, 0, 1, 2],
  Facing.left: [6, 15, 24, 3, 12, 21, 0, 9, 18],
  Facing.right: [26, 17, 8, 23, 14, 5, 20, 11, 2],
  Facing.front: [24, 25, 26, 21, 22, 23, 18, 19, 20],
  Facing.back: [8, 7, 6, 5, 4, 3, 2, 1, 0],
};

const List<Facing> cubeFaces = [
  Facing.top,
  Facing.down,
  Facing.left,
  Facing.right,
  Facing.front,
  Facing.back,
];

const List<int> cubeArrangeX = [18, 9, 0, 21, 12, 3, 24, 15, 6, 19, 10, 1, 22, 13, 4, 25, 16, 7, 20, 11, 2, 23, 14, 5, 26, 17, 8];

// const List<List<int>> layer3ArrangeByRow = [[0,1,2], [3,4,5], [6,7,8]];
// const List<List<int>> layer3ArrangeByColumn = [[0,3,6], [1,4,7], [2,5,8]];
// const List<List<int>> layer2ArrangeByRow = [[9,10,11], [12,13,14],[15,16,17]];
// const List<List<int>> layer2ArrangeByColumn = [[9,12,15], [10,13,16], [11,14,17]];
// const List<List<int>> layer1ArrangeByRow = [[18,19, 20], [21,22,23],[24,25,26]];
// const List<List<int>> layer1ArrangeByColumn = [[18,21,24], [19,22,25], [20,23,26]];
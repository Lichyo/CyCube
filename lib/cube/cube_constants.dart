import 'package:flutter/material.dart';
import 'dart:math';

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
const List<int> cubeArrangeXReverse = [2, 11, 20, 5, 14, 23, 8, 17, 26, 1, 10, 19, 4, 13, 22, 7, 16, 25, 0, 9, 18, 3, 12, 21, 6, 15, 24];
const List<int> cubeArrangeY = [6, 7, 8, 15, 16, 17, 24, 25, 26, 3, 4, 5, 12, 13, 14, 21, 22, 23, 0, 1, 2, 9, 10, 11, 18, 19, 20];
const List<int> cubeArrangeYReverse = [18, 19, 20, 9, 10, 11, 0, 1, 2, 21, 22, 23, 12, 13, 14, 3, 4, 5, 24, 25, 26, 15, 16, 17, 6, 7, 8];

const List<int> removeTop = [0,1,2,3,4,5,9,10,11,12,13,14,18,19,20,21,22,23];
const List<int> removeDown = [3,4,5,6,7,8,12,13,14,15,16,17,21,22,23,24,25,26];
const List<int> removeRight = [0,9,18,3,12,21,6,15,24, 1,10,19,4,13,22,7,16,25];
const List<int> removeLeft = [1,10,19,4,13,22,7,16,25, 2,11,20,5,14,23,8,17,26];
const List<int> removeFront = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
const List<int> removeBack = [9,10,11,12,13,14,15,16,17, 18,19,20,21,22,23,24,25,26];

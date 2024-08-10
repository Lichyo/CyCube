import 'package:flutter/material.dart';

class Tools {
  static String transformColorToString(Color color) {
    if (color == Colors.red) {
      return 'red';
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

  static Color transformStringToColor(String color) {
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'orange') {
      return Colors.orange;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'yellow') {
      return Colors.yellow;
    } else if (color == 'blue') {
      return Colors.blue;
    } else if (color == 'black') {
      return Colors.black;
    } else {
      return Colors.green;
    }
  }
}

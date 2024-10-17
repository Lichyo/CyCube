import 'arrow.dart';

class ArrowState {
  late double offsetX = 0;
  late double offsetY = 0;
  late double offsetZ = 0;
  late double rotateX = 0;
  late double rotateY = 0;
  late double rotateZ = 0;
  late ArrowDirection arrowDirection = ArrowDirection.none;
  ArrowState(
      {required this.offsetX,
        required this.offsetY,
        required this.offsetZ,
        required this.rotateX,
        required this.rotateY,
        required this.rotateZ,
        required this.arrowDirection});

  void updateValueFromMap(Map<String, dynamic> newData) {
    newData.forEach((key, value) {
      switch (key) {
        case 'offsetX':
          if (value is double) {
            offsetX = value;
          }
          break;
        case 'offsetY':
          if (value is double) {
            offsetY = value;
          }
          break;
        case 'offsetZ':
          if (value is double) {
            offsetZ = value;
          }
          break;
        case 'rotateX':
          if (value is double) {
            rotateX = value;
          }
          break;
        case 'rotateY':
          if (value is double) {
            rotateY = value;
          }
          break;
        case 'rotateZ':
          if (value is double) {
            rotateZ = value;
          }
          break;
        case 'arrowDirection':
          if (value is ArrowDirection) {
            arrowDirection = value;
          }
          break;
      }
    });
  }
}

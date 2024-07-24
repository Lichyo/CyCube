import 'cube_component.dart';

class SingleCubeModel {
  final double x;
  final double y;
  final double z;
  CubeComponent component;

  SingleCubeModel({
    required this.component,
    required this.x,
    required this.y,
    required this.z,
  });
}

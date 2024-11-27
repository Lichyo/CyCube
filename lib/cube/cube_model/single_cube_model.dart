import '../cube_view/cube_component.dart';

class SingleCubeModel {
  double x;
  double y;
  double z;
  late CubeComponent component;

  SingleCubeModel({
    required this.component,
    required this.x,
    required this.y,
    required this.z,
  });

}

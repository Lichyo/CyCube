import 'package:cube/cube/cube_component.dart';
import 'single_cube_model.dart';

class CubeState {
  List<SingleCubeModel> cubeModels = [];
  final double width;

  CubeState({required this.width}) {
    int id = 0;
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cubeModels.add(
            SingleCubeModel(
              id: id,
              component: CubeComponent(
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
}

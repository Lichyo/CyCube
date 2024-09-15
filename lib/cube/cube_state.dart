import 'package:cy_cube/cube/cube_controller/arrange_controller.dart';
import 'package:cy_cube/cube/cube_controller/extension_controller.dart';
import 'package:cy_cube/cube/cube_controller/rotation_controller.dart';
import 'package:cy_cube/cube/cube_controller/setup_controller.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'package:cy_cube/cube/cube_model/single_cube_model.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/components/single_cube_face.dart';
import 'package:flutter/material.dart';

class CubeState extends ChangeNotifier {
  static List<SingleCubeModel> cubeModels = [];
  static List<int> indexWithStack = [];

  double get cubeDx => ArrangeController.dx;

  double get cubeDy => ArrangeController.dy;

  final SetupController _setupController = SetupController();
  final RotationController _rotationController = RotationController();
  final ExtensionController _extensionController = ExtensionController();
  final ArrangeController _arrangeController = ArrangeController();

  CubeState() {
    initCubeState();
    notifyListeners();
  }

  void initCubeState() {
    cubeModels = [];
    indexWithStack = [];
    int id = 0;
    for (int z = -1; z < 2; z++) {
      for (int y = -1; y < 2; y++) {
        for (int x = -1; x < 2; x++) {
          cubeModels.add(
            SingleCubeModel(
              component: CubeComponent(
                cubeColor: Map.from(defaultCubeColor),
              ),
              x: x * cubeWidth,
              y: -y * cubeWidth,
              z: z * cubeWidth,
            ),
          );
          indexWithStack.add(id);
          id++;
        }
      }
    }
  }

  void rotate({required String rotation}) {
    _rotationController.rotate(rotation: rotation);
    notifyListeners();
  }

  Color getColor({required String color}) {
    return _setupController.getColor(color);
  }

  void setupCubeWithScanningColor(
      List<List<SingleCubeComponentFaceModel>> cubeFaces) {
    _setupController.setupCubeWithScanningColor(cubeFaces);
    notifyListeners();
  }

  List<String> generateCubeStatus() {
    return _setupController.generateCubeStatus();
  }

  void setCubeStatus({required List<String> cubeStatus}) {
    _setupController.setCubeStatus(cubeStatus: cubeStatus);
    notifyListeners();
  }

  SingleCubeFace show2DFace({required Facing facing}) {
    return _extensionController.show2DFace(facing: facing);
  }

  void listenToArrange({required DragUpdateDetails detail}) {
    _arrangeController.listenToArrange(detail: detail);
    print("arrange");
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/components/pick_color_container.dart';
import 'package:cy_cube/cube/single_cube_component_face_model.dart';
import 'package:cy_cube/components/single_cube_face.dart';

class CubeSetupPage extends StatefulWidget {
  const CubeSetupPage({super.key});

  @override
  State<CubeSetupPage> createState() => _CubeSetupPageState();
}

class _CubeSetupPageState extends State<CubeSetupPage> {
  int _currentID = 0;
  Color pickColor = Colors.white;
  List<SingleCubeComponentFaceModel> cubeFaces = [];
  List<List<SingleCubeComponentFaceModel>> allCubeFaces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCubeFaces();
  }

  void initCubeFaces() {
    cubeFaces = [];
    cubeFaces.add(SingleCubeComponentFaceModel(id: 0, isSelected: true));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 1, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 2, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 3, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 4, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 5, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 6, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 7, isSelected: false));
    cubeFaces.add(SingleCubeComponentFaceModel(id: 8, isSelected: false));
  }

  void selectColor(Color color) {
    setState(() {
      cubeFaces[_currentID].color = color;
      cubeFaces[_currentID].isSelected = false;
      _currentID++;
      if (_currentID != 9) {
        cubeFaces[_currentID].isSelected = true;
      } else {
        _currentID = 0;
        allCubeFaces.add(cubeFaces);
        if (allCubeFaces.length == 6) {
          Navigator.pop(context, [allCubeFaces]);
        } else {
          initCubeFaces();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleCubeFace(singleCubeComponentFaces: cubeFaces),
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PickColorContainer(
                color: Colors.white,
                onTap: () {
                  selectColor(Colors.white);
                },
              ),
              PickColorContainer(
                color: Colors.yellow,
                onTap: () {
                  selectColor(Colors.yellow);
                },
              ),
              PickColorContainer(
                color: Colors.red,
                onTap: () {
                  selectColor(Colors.red);
                },
              ),
              PickColorContainer(
                color: Colors.orange,
                onTap: () {
                  selectColor(Colors.orange);
                },
              ),
              PickColorContainer(
                color: Colors.blue,
                onTap: () {
                  selectColor(Colors.blue);
                },
              ),
              PickColorContainer(
                color: Colors.green,
                onTap: () {
                  selectColor(Colors.green);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


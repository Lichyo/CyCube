import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/components/pick_color_container.dart';
import 'package:cy_cube/cube/cube_face_model.dart';
import 'package:cy_cube/components/single_cube_face.dart';

class CubeSetupPage extends StatefulWidget {
  const CubeSetupPage({super.key});

  @override
  State<CubeSetupPage> createState() => _CubeSetupPageState();
}

class _CubeSetupPageState extends State<CubeSetupPage> {
  int _currentID = 0;
  Color pickColor = Colors.white;
  List<CubeFaceModel> cubeFaces = [];
  List<List<CubeFaceModel>> allCubeFaces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCubeFaces();
  }

  void initCubeFaces() {
    cubeFaces = [];
    cubeFaces.add(CubeFaceModel(id: 0, isSelected: true));
    cubeFaces.add(CubeFaceModel(id: 1, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 2, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 3, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 4, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 5, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 6, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 7, isSelected: false));
    cubeFaces.add(CubeFaceModel(id: 8, isSelected: false));
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleCubeFace(cubeFaceModel: cubeFaces[6]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[7]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[8]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleCubeFace(cubeFaceModel: cubeFaces[3]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[4]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[5]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleCubeFace(cubeFaceModel: cubeFaces[0]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[1]),
                  SingleCubeFace(cubeFaceModel: cubeFaces[2]),
                ],
              ),
            ],
          ),
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

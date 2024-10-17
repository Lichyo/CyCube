import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'package:cy_cube/components/pick_color_container.dart';
import 'dart:convert';
import 'package:cy_cube/components/single_cube_face.dart';
import 'package:cy_cube/service/image_controller.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CubeSetupPageAuto extends StatefulWidget {
  CubeSetupPageAuto({
    super.key,
    required this.socket,
  });

  final IO.Socket socket;

  @override
  State<CubeSetupPageAuto> createState() => _CubeSetupPageAutoState();
}

class _CubeSetupPageAutoState extends State<CubeSetupPageAuto> {
  Timer? _timer;
  bool initColorMode = false;
  List<SingleCubeComponentFaceModel> cubeFaces = [];
  List<List<SingleCubeComponentFaceModel>> allCubeFaces = [];
  String currentColor = '';
  bool startRecording = false;

  void initCubeFaces() {
    cubeFaces = [];
    for (int i = 0; i < 9; i++) {
      cubeFaces.add(SingleCubeComponentFaceModel(id: i));
    }
  }

  @override
  void initState() {
    super.initState();
    initCubeFaces();
    widget.socket.emit("join", Config.user);
    widget.socket.on('receive_image', (data) async {
      await ImageController.updateImage(data);
      setState(() {});
    });
    widget.socket.on('return_cube_color', (data) {
      setState(() {
        try {
          List<String> cubeColors = List<String>.from(data);
          for (int i = 0; i < 9; i++) {
            cubeFaces[i].color = ImageController.getColor(cubeColors[i]);
          }
        } catch (e) {
          print(e);
        }
      });
    });
    widget.socket.on("init_color_dataset", (data) {});
    ImageController.initializeCamera(Config.cameras![0]).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CyCube Setup',
          style: GoogleFonts.adamina(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                initColorMode = !initColorMode;
              });
            },
            icon: const Icon(
              Icons.colorize,
            ),
          ),
          IconButton(
            onPressed: () {
              if (_timer != null && _timer!.isActive) {
                _timer!.cancel();
              } else {
                _timer =
                    Timer.periodic(const Duration(milliseconds: 125), (timer) {
                  ImageController.convertCameraImageToJpeg(
                          ImageController.imageBuffer!)
                      .then((value) {
                    widget.socket.emit('save_image', base64Encode(value));
                  });
                  setState(() {
                    widget.socket.emit('receive_image');
                  });
                  if (!initColorMode) {
                    widget.socket.emit("initialize_cube_color");
                  } else {
                    if (startRecording) {
                      widget.socket.emit("init_color_dataset", currentColor);
                    }
                  }
                });
              }
            },
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () {
              widget.socket.emit("clear_color_dataset");
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (initColorMode) {
            setState(() {
              startRecording = !startRecording;
            });
            if (startRecording) {
              Future.delayed(const Duration(seconds: 5)).then((_) {
                startRecording = false;
              });
            }
          } else {
            setState(() {
              allCubeFaces.add(cubeFaces);
              initCubeFaces();
            });
            if (allCubeFaces.length == 6) {
              Navigator.pop(context, [allCubeFaces]);
            }
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: allCubeFaces.length / 6,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.grey,
            ),
            const MaxGap(50),
            Visibility(
              visible: !initColorMode,
              child: SingleCubeFace(
                singleCubeComponentFaces: cubeFaces,
              ),
            ),
            Visibility(
              visible: initColorMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PickColorContainer(
                    color: Colors.white,
                    onTap: () {
                      currentColor = 'white';
                    },
                  ),
                  PickColorContainer(
                    color: Colors.yellow,
                    onTap: () {
                      currentColor = 'yellow';
                    },
                  ),
                  PickColorContainer(
                    color: Colors.red,
                    onTap: () {
                      currentColor = 'red';
                    },
                  ),
                  PickColorContainer(
                    color: Colors.orange,
                    onTap: () {
                      currentColor = 'orange';
                    },
                  ),
                  PickColorContainer(
                    color: Colors.blue,
                    onTap: () {
                      currentColor = 'blue';
                    },
                  ),
                  PickColorContainer(
                    color: Colors.green,
                    onTap: () {
                      currentColor = 'green';
                    },
                  ),
                ],
              ),
            ),
            const Gap(80),
            Stack(
              children: [
                if (ImageController.imageInWidget1 != null)
                  Opacity(
                    opacity: ImageController.toggle ? 1.0 : 0.0,
                    child: ImageController.imageInWidget1!,
                  ),
                if (ImageController.imageInWidget2 != null)
                  Opacity(
                    opacity: ImageController.toggle ? 0.0 : 1.0,
                    child: ImageController.imageInWidget2!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}

import 'package:cy_cube/view/cube_setup_page_auto.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/service/database_service.dart';
import 'package:cy_cube/service/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'dart:convert';
import 'package:cy_cube/config.dart';
import 'package:cy_cube/cube/cube_view/cube_page.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({
    super.key,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late IO.Socket _socket;
  late Timer _timer;
  bool isCourseStart = false;
  TextEditingController roomIDController = TextEditingController();
  bool isLoad = false;
  bool isJoinRoom = false;
  String _predictionResult = "";
  String role = "teacher";
  String connectionStatus = "Unconnected";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeSocket();
  }

  void startCourse() {
    _initializeSocket();
    if (ImageController.controller != null) {
      ImageController.controller!.dispose();
    }
    ImageController.initializeCamera(Config.cameras![0]).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
    // _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    //   ImageController.convertCameraImageToJpeg(ImageController.imageBuffer!)
    //       .then((value) {
    //     _socket.emit('rotation', base64Encode(value));
    //   });
    // });
  }

  void _initializeSocket() {
    _socket = IO.io(Config.serverIP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connect', (data) {
      setState(() {
        connectionStatus = "Connected";
      });
    });
    _socket.on('rotation', (data) {
      setState(() {
        _predictionResult = data.toString();
      });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isJoinRoom
        ? Scaffold(
            appBar: AppBar(
              title: Text(roomIDController.text.length >= 3
                  ? roomIDController.text
                  : "CyCube"),
            ),
            body: Stack(
              children: [
                role == "student"
                    ? Column(
                        children: [
                          const MaxGap(200),
                          CubePage(),
                          const Gap(100),
                          CubeRotationTable(
                            onPressed: (rotation) async {
                              Provider.of<CubeState>(context, listen: false)
                                  .rotate(rotation: rotation);
                              await DatabaseService
                                  .updateCubeStateWithStudentPOV(
                                      rotation: rotation,
                                      roomID: roomIDController.text,);
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const MaxGap(200),
                          CubePage(),
                          const Gap(100),
                        ],
                      ),
              ],
            ),
          )
        : isLoad
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: roomIDController,
                          decoration: InputDecoration(
                            labelText: 'Room ID',
                            prefixIcon: const Icon(Icons.numbers),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16.0),
                        const Gap(10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                role = "teacher";
                                print(role);
                              });
                              await DatabaseService.joinRoom(
                                roomID: roomIDController.text,
                                context: context,
                              );
                              setState(() {
                                isJoinRoom = true;
                                isCourseStart = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Background color
                              foregroundColor: Colors.white, // Text color
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Join the Room ( Teacher )'),
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                role = "student";
                                print("student");
                              });
                              var data = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CubeSetupPageAuto(socket: _socket),
                                ),
                              );
                              List<List<SingleCubeComponentFaceModel>>
                                  cubeFaces = data[0];
                              Provider.of<CubeState>(context, listen: false)
                                  .setupCubeWithScanningColor(cubeFaces);
                              roomIDController.text =
                                  await DatabaseService.createRoom(
                                      context: context);
                              print("room ID : " + roomIDController.text);
                              setState(() {
                                isJoinRoom = true;
                                isCourseStart = true;
                                startCourse();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey, // Background color
                              foregroundColor: Colors.white, // Text color
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                                'Cube init & Create the Room ( Student )'),
                          ),
                        ),
                        const Gap(50),
                        Text(
                          connectionStatus,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }

  @override
  void dispose() {
    _socket.dispose();
    ImageController.controller!.stopImageStream();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }
}

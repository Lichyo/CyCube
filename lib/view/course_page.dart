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
  String role = "";

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
    ImageController.initializeCamera(Config.cameras![1]).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
    _timer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      ImageController.convertCameraImageToJpeg(ImageController.imageBuffer!)
          .then((value) {
        _socket.emit('rotation', base64Encode(value));
      });
    });
  }

  void _initializeSocket() {
    _socket = IO.io(Config.serverIP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('rotation', (data) {
      if (data != "wait") {
        Provider.of<CubeState>(context, listen: false)
            .rotate(rotation: data.toString());
        DatabaseService.updateCubeStateWithStudentPOV(
            rotation: data.toString(), roomID: roomIDController.text);
        setState(() {
          _predictionResult = data.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isJoinRoom
        ? Stack(
            children: [
              role == "student"
                  ? Center(
                      child: CameraPreview(
                        ImageController.controller!,
                      ),
                    )
                  : Container(),
              Positioned(
                top: 600,
                left: MediaQuery.of(context).size.width / 2 - 10,
                child: CubePage(),
              ),
              role == "student"
                  ? Positioned(
                      top: 130,
                      left: 20,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Rotation : $_predictionResult",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
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

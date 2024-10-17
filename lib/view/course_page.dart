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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeSocket();
  }

  void startCourse() {
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
      Provider.of<CubeState>(context, listen: false)
          .rotate(rotation: data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return isJoinRoom
        ? Stack(
            children: [
              Center(
                child: CameraPreview(
                  ImageController.controller!,
                ),
              ),
              Positioned(
                top: 600,
                left: MediaQuery.of(context).size.width / 2 - 10,
                child: CubePage(),
              ),
              Positioned(
                top: 130,
                left: 20,
                child: Text(
                  "result : $_predictionResult",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
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
                              try {
                                await DatabaseService.joinRoom(
                                    roomID: roomIDController.text,
                                    context: context);
                                setState(() {
                                  isJoinRoom = true;
                                });
                              } catch (e) {
                                print(e);
                              }
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
                              var data = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CubeSetupPageAuto(socket: _socket),
                                ),
                              );
                              List<List<SingleCubeComponentFaceModel>>
                                  cubeFaces = data[0];
                              setState(() async {
                                roomIDController.text =
                                    await DatabaseService.createRoom(
                                  context: context,
                                );
                              });

                              Provider.of<CubeState>(context, listen: false)
                                  .setupCubeWithScanningColor(cubeFaces);
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
    _timer.cancel();
    super.dispose();
  }
}

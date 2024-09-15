import 'package:cy_cube/components/cube_state_in_2D.dart';
import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:cy_cube/view/cube_setup_page_auto.dart';
import 'package:camera/camera.dart';
import 'package:cy_cube/view/cube_setup_page_manual.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:cy_cube/service/database_service.dart';
import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/view/course_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CubeState _cubeState = CubeState();
  String? _roomID;
  bool _isJoinCourseRoom = false;
  bool _isCreateRoom = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onPanUpdate: (detail) {
              setState(() {
                _cubeState.listenToArrange(detail: detail);
              });
            },
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Join Room'),
                            content: const Text('Enter room ID to join a room'),
                            actions: [
                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  _roomID = value;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('cancel'),
                                  ),
                                  TextButton(
                                    child: const Text('Join'),
                                    onPressed: () async {
                                      await DatabaseService.joinRoom(
                                        email: 'lichyo003@gmail.com',
                                        roomID: _roomID!,
                                        cubeState: _cubeState,
                                      );
                                      _isJoinCourseRoom = true;
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.door_back_door_outlined),
                  ),
                ],
                elevation: 5,
                title: GestureDetector(
                  onDoubleTap: () {},
                  child: Text(
                    _roomID ?? 'CyCube',
                    style: GoogleFonts.aboreto(
                      fontSize: 27.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                centerTitle: true,
              ),
              body: Builder(
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MaxGap(200),
                      Transform(
                        origin: const Offset(0, 0),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateX(_cubeState.cubeDy * pi / 180)
                          ..rotateY(_cubeState.cubeDx * pi / 180)
                          ..setEntry(2, 2, 0.001),
                        child: Center(
                          child: Cube(),
                        ),
                      ),
                      const Gap(100),
                      Visibility(
                        visible: !_isJoinCourseRoom,
                        child: CubeRotationTable(
                          onPressed: (rotation) {
                            _cubeState.rotate(rotation: rotation);
                            if (_roomID != null) {
                              DatabaseService.courseWithStudentPOV(
                                rotation: rotation,
                                roomID: _roomID!,
                              );
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: !_isJoinCourseRoom && !_isCreateRoom,
                        child: TextButton(
                          onPressed: () async {
                            _roomID = await DatabaseService.createRoom(
                              email: 'lichyo003@gmail.com',
                              cubeState: _cubeState,
                            );
                            _isCreateRoom = true;
                            setState(() {});
                          },
                          child: const Text('create room'),
                        ),
                      ),
                      const MaxGap(100),
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CubeStateIn2D(cubeState: _cubeState);
                            },
                          );
                          _cubeState.show2DFace(facing: Facing.top);
                        },
                        child: Image.asset(
                          'images/cube_icon.png',
                          width: 80,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

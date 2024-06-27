import 'package:cy_cube/cube/cube_rotation_table.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:cy_cube/service/database_service.dart';

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  CubeState cubeState = CubeState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubeState.setOnStateChange(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cubeState.setOnStateChange(null);
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onPanUpdate: (detail) {
          setState(() {
            _offset += detail.delta;
          });
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  String roomID = '';
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
                              roomID = value;
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
                                    roomID: roomID,
                                    cubeState: cubeState,
                                  );
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
            title: Text(
              'The Cube',
              style: GoogleFonts.aboreto(
                fontSize: 27.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(50),
              Transform(
                origin: const Offset(0, 0),
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_offset.dy * pi / 180)
                  ..rotateY(_offset.dx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: Cube(),
                ),
              ),
              const Gap(100),
              CubeRotationTable(
                onPressed: (rotation) {
                  cubeState.rotate(rotation);
                  setState(() {});
                },
              ),
              TextButton(
                onPressed: () async {
                  int roomID = await DatabaseService.createRoom(
                    email: 'lichyo003@gmail.com',
                    cubeState: cubeState,
                  );
                },
                child: const Text('create room'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

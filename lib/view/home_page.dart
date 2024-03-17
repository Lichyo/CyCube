import 'package:cube/cube/cube_state.dart';
import 'package:flutter/material.dart';
import 'package:cube/cube/cube.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:camera/camera.dart';
import 'package:cube/view/cube_setup_page.dart';
import 'package:cube/model/cube_face.dart';

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key, required this.camera});

  final List<CameraDescription> camera;

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  CubeState cubeState = CubeState(width: 40);

  bool isRecording = false;

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
                onPressed: () async {
                  final results = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CubeSetupPage()));
                  final List<List<CubeFaceModel>> allCubeFaces = results[0];
                  setState(() {
                    cubeState.setupCubeWithScanningColor(allCubeFaces);
                  });
                },
                icon: const Icon(
                  Icons.camera,
                  size: 27.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.update),
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
              Transform(
                origin: const Offset(0, 0),
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_offset.dy * pi / 180)
                  ..rotateY(_offset.dx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: Cube(cubeState: cubeState),
                ),
              ),
              const Gap(200),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.dMove();
                            });
                          },
                          child: const Text('D')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.bMove();
                            });
                          },
                          child: const Text('B')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.lMove();
                            });
                          },
                          child: const Text('L')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.uMove();
                            });
                          },
                          child: const Text('U')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.fMove();
                            });
                          },
                          child: const Text('F')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.rMove();
                            });
                          },
                          child: const Text('R')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.dMoveReverse();
                            });
                          },
                          child: const Text('D\'')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.bMoveReverse();
                            });
                          },
                          child: const Text('B\'')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.lMoveReverse();
                            });
                          },
                          child: const Text('L\'')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.uMoveReverse();
                            });
                          },
                          child: const Text('U\'')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              cubeState.fMoveReverse();
                            });
                          },
                          child: const Text('F\'')),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            cubeState.rMoveReverse();
                          });
                        },
                        child: const Text('R\''),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        cubeState = CubeState(width: 40);
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: const Text('open camera'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

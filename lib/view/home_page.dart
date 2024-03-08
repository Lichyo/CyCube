import 'package:cube/cube/cube_component.dart';
import 'package:cube/cube/cube_state.dart';
import 'package:cube/cube/single_cube_model.dart';
import 'package:flutter/material.dart';
import 'package:cube/cube/cube.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:gap/gap.dart';

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  CubeState cubeState = CubeState(width: 40);

  @override
  void initState() {
    super.initState();
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

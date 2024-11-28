import 'package:cy_cube/cube/cube_constants.dart';
import 'package:cy_cube/cube/cube_view/cube_component.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CyCube"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset += details.delta;
                });
              },
              child: Transform(
                origin: const Offset(0, 0),
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(offset.dy * pi / 180)
                  ..rotateY(offset.dx * pi / 180)
                  ..setEntry(2, 2, 0.001),
                child: Center(
                  child: CubeComponent(
                    cubeColor: defaultCubeColor,
                    visibleControl: const {
                      Facing.top: true,
                      Facing.down: true,
                      Facing.left: true,
                      Facing.right: true,
                      Facing.front: true,
                      Facing.back: true,
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

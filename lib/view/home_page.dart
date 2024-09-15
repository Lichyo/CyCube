import 'package:cy_cube/cube/cube_state.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CubeState _cubeState = CubeState();

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
              Provider.of<CubeState>(context, listen: false)
                  .listenToArrange(detail: detail);
            },
            child: Scaffold(
              body: CubePage(cubeState: _cubeState),
            ),
          );
        },
      ),
    );
  }
}

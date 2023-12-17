import 'package:flutter/material.dart';
import 'package:cube/cube/service/cube_rotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cube/service/auth_service.dart';

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  final AuthService _auth = AuthService();
  CubeRotation cubeRotation = CubeRotation();
  List<Widget> cubes = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    cubes = cubeRotation.cubes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onPanUpdate: (detail) {
          setState(() {
            _offset += detail.delta;
            cubes = cubeRotation.permutateCube(offset: _offset);
          });
        },
        child: Scaffold(
          drawer: Drawer(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  color: Colors.teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage('assets/images/lichyo.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          'lichyo',
                          style: GoogleFonts.getFont(
                            'Ubuntu',
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () async {
                    await _auth.logout();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: double.infinity,
                    color: Colors.grey.shade500.withOpacity(0.1),
                    child: const Text('    Logout'),
                  ),
                ),
              ],
            ),
          ),
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
                  child: Stack(
                    children: cubes,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

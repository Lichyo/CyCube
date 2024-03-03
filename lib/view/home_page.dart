import 'package:flutter/material.dart';
import 'package:cube/cube.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cube/service/auth_service.dart';
import 'package:cube/components/drawer.dart';

class RubiksCube extends StatefulWidget {
  const RubiksCube({super.key});

  @override
  State<RubiksCube> createState() => _RubiksCubeState();
}

class _RubiksCubeState extends State<RubiksCube> {
  Offset _offset = Offset.zero;
  final AuthService _auth = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;

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
          drawer: CustomDrawer(auth: _auth),
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
                  child: Cube(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

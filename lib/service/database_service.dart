import 'package:provider/provider.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cy_cube/service/auth_service.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> createRoom({
    required BuildContext context,
  }) async {
    final List<String> cubeStatus =
        Provider.of<CubeState>(context, listen: false).generateCubeStatus();
    int randomRoomID = Random().nextInt(900000) + 100000;
    String roomID = randomRoomID.toString();
    await _firestore.collection('rooms').doc(roomID).set({
      'cube_status': cubeStatus,
      'student': AuthService.currentUser!.email,
      'teacher': '',
      'next_move': '',
    });
    return roomID;
  }

  static Future<List<String>> joinRoom({
    required String roomID,
    required BuildContext context,
  }) async {
    var roomData = await _firestore.collection('rooms').doc(roomID).get();
    final List<dynamic> data = roomData['cube_status'];
    List<String> cubeStatus = [];
    for (String cubeState in data) {
      cubeStatus.add(cubeState.toString());
    }
    Provider.of<CubeState>(context, listen: false)
        .setCubeStatus(cubeStatus: cubeStatus);
    startCourseWithTeacherPOV(roomID: roomID, context: context);
    return cubeStatus;
  }

  static Future<void> startCourseWithTeacherPOV({
    required String roomID,
    required BuildContext context,
  }) async {
    String nextMove = '';
    _firestore.collection('rooms').doc(roomID).snapshots().listen((snapshot) {
      var data = snapshot.data();
      nextMove = data!['next_move'];
      Provider.of<CubeState>(context, listen: false).rotate(rotation: nextMove);
      Provider.of<CubeState>(context).nextMove = nextMove;
    });
  }

  static Future<void> updateCubeStateWithStudentPOV({
    required String rotation,
    required String roomID,
  }) async {
    var data = await _firestore.collection('rooms').doc(roomID).get();
    String previousRotation = data['next_move'];
    if (previousRotation == rotation) {
      await _firestore.collection('rooms').doc(roomID).update({
        'next_move': '',
      });
    }
    await _firestore.collection('rooms').doc(roomID).update({
      'next_move': rotation,
    });
    print("DateTime : ${DateTime.now()}");
  }
}

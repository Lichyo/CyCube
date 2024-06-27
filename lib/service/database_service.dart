import 'package:cy_cube/cube/cube_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<int> createRoom({
    required CubeState cubeState,
    required String email,
  }) async {
    final List<String> cubeStatus = cubeState.outputCubeState();
    int randomRoomID = Random().nextInt(900000) + 100000;
    await _firestore.collection('rooms').doc(randomRoomID.toString()).set({
      'cube_status': cubeStatus,
      'student': email,
      'teacher': '',
      'next_move': '',
    });
    return randomRoomID;
  }

  static Future<List<String>> joinRoom({
    required String email,
    required String roomID,
    required CubeState cubeState,
  }) async {
    await _firestore.collection('rooms').doc(roomID).update({
      'teacher': email,
    });
    var roomData = await _firestore.collection('rooms').doc(roomID).get();
    final List<dynamic> data = roomData['cube_status'];
    List<String> cubeStatus = [];
    for (String cubeState in data) {
      cubeStatus.add(cubeState.toString());
      print(cubeState.toString());
    }
    cubeState.setCubeState(cubeStatus: cubeStatus);
    _startCourse(roomID: roomID, cubeState: cubeState);
    return cubeStatus;
  }

  static Future<void> _startCourse({
    required String roomID,
    required CubeState cubeState,
  }) async {
    String nextMove = '';
    _firestore.collection('rooms').doc(roomID).snapshots().listen((snapshot) {
      var data = snapshot.data();
      nextMove = data!['next_move'];
      cubeState.rotate(nextMove);
    });
  }
}

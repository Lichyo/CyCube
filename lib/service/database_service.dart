import 'package:cy_cube/cube/cube_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class DatabaseServiceWithSocket {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> createRoom({
    required CubeState cubeState,
    required String email,
  }) async {
    final List<String> cubeStatus = cubeState.outputCubeState();
    int randomRoomID = Random().nextInt(900000) + 100000;
    await _firestore.collection('rooms').doc(randomRoomID.toString()).set({
      'cube_state': cubeStatus,
      'email': email,
    });
    print(randomRoomID);
    return randomRoomID;
  }

  Future<String> joinRoom({
    required String email,
    required int roomID,
  }) async {
    String nextMove = '';
    _firestore
        .collection('rooms')
        .doc(roomID.toString())
        .snapshots()
        .listen((snapshot) {
          nextMove = snapshot['rotation'];
    });
    print(nextMove);
    return nextMove;
  }
}

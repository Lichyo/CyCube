import 'dart:convert';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:http/http.dart' as http;

class DatabaseServiceWithSocket {
  Future<int> createRoom(
      {required CubeState cubeState, required String email}) async {
    final List<String> cubeStatus = cubeState.generateCubeStatus();
    var response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/room/create?cube_state=$cubeStatus&email=$email'));
    final int roomID = jsonDecode(response.body);
    return roomID;
  }

  Future<List<String>> joinRoom(
      {required String email, required int roomID}) async {
    var response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/room/join?email=$email&roomID=$roomID'));
    final List<dynamic> temp = jsonDecode(response.body);
    final List<String> cubeStatus =
        temp.map((item) => item.toString()).toList();
    return cubeStatus;
  }

  Future<void> quitRoom({required int roomID}) async {
    await http.get(Uri.parse('http://127.0.0.1:5000/room/quit?roomID=$roomID'));
  }
}

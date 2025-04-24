import 'package:camera/camera.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/config.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:cy_cube/service/image_controller.dart';
import 'package:cy_cube/cube/cube_view/cube_page.dart';
import 'dart:async';
import 'dart:convert';

class Lab extends StatefulWidget {
  const Lab({super.key});

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  late IO.Socket _socket;
  late Timer _timer;
  String connectionStatus = "Unconnected";
  late CameraController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeSocket();
    ImageController.initializeCamera(Config.cameras![1]).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _initializeSocket() {
    _socket = IO.io(Config.serverIP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connect', (data) {
      setState(() {

        connectionStatus = "Connected";
      });
    });
    _socket.on('disconnect', (data) {
      setState(() {
        connectionStatus = "Disconnected";
      });
    });
    _socket.on('rotation', (data) {
      String rotation = data['predictedResult'];
      print(rotation);
      if (rotation != "wait") {
        print(rotation);
        Provider.of<CubeState>(context, listen: false)
            .rotate(rotation: rotation);
      }
    });

    _socket.on('receive_image', (data) async {
      await ImageController.updateImage(data);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
            ImageController.convertCameraImageToJpeg(
                    ImageController.imageBuffer!)
                .then((value) {
              // _socket.emit('save_image', base64Encode(value));
              _socket.emit("rotation", base64Encode(value));
              // print("send image");
            });
          });
        },
        child: const Icon(Icons.flash_on),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lab'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(
                    ImageController.controller!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350),
                  child: CubePage(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30),
                  child: Text(
                    connectionStatus,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _socket.disconnect();
    _timer.cancel();
    ImageController.controller!.dispose();
    super.dispose();
  }
}

import 'package:gap/gap.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'package:cy_cube/service/image_controller.dart';
import 'package:cy_cube/config.dart';
import 'dart:convert';

class Lab extends StatefulWidget {
  const Lab({super.key});

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  late IO.Socket _socket;
  late Timer _timer;
  String predictedResult = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageController.initializeCamera(Config.cameras![0]).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
    _socket = IO.io(Config.serverIP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('rotation', (data) {
      setState(() {
        print(data);
        predictedResult = data;
      });
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
    return Stack(
      children: [
        Center(child: CameraPreview(ImageController.controller!)),
        Positioned(
          top: 50,
          child: Text(
            "Predicted Result: $predictedResult",
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        Positioned(
          top: 650,
          left: 150,
          child: TextButton(
            onPressed: () {
              _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
                ImageController.convertCameraImageToJpeg(ImageController.imageBuffer!)
                    .then((value) {
                  _socket.emit('rotation', base64Encode(value));
                });
              });
            },
            child: const Text(
              "Start",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

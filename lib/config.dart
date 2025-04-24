import 'package:camera/camera.dart';

class Config {
  static String _serverIP = "http://192.168.205.251:5000";

  static String get serverIP => _serverIP;
  static String user = "chiyu";
  static String lottieCubeAsset =
      "https://lottie.host/b21f9cbc-25f5-46e6-94b0-55f1db7f9770/pGw3ZbkZoq.json";
  static List<CameraDescription>? cameras;

  static setIP(String ip, String port) {
    _serverIP = "http://$ip:$port";
  }

  static Future<void> initCamera() async {
    cameras = await availableCameras();
  }
}

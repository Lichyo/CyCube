import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataProcessor {
  final _firebase = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  DataProcessor();

  void uploadImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List byte = await image.readAsBytes();
      _firebase.ref().putData(byte);
      return;
    } else {
      throw Exception('image upload fail');
    }
  }
}

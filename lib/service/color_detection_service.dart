import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ColorDetectionService {
  static Uint8List capture({
    required int width,
    required int height,
    required Uint8List bytes,
  }) {
    print('bytes length : ${bytes.lengthInBytes}');
    // img.Image image = img.Image.fromBytes(
    //   width,
    //   height,
    //   bytes,
    //   format: img.Format.bgra,
    // );
    return bytes;
    // List<int> jpg = Uint8List.fromList(img.encodeJpg(image));
    // print('jpg length: ${jpg.length}');
    // return jpg;
  }
}

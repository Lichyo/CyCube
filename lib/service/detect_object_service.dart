import 'package:tflite_flutter/tflite_flutter.dart' as tf;
import 'package:flutter/services.dart';

class DetectObjectService {
  late tf.Interpreter interpreter;
  List<String>? labels;

  DetectObjectService() {
    _loadModel();
    _loadLabels();
  }

  Future<void> _loadModel() async {
    final options = tf.InterpreterOptions();

    interpreter =
        await tf.Interpreter.fromAsset('assets/cube.tflite', options: options);
    tf.Tensor inputTensor = interpreter.getInputTensors().first;
    tf.Tensor outputTensor = interpreter.getOutputTensors().first;
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString('assets/labels.txt');
    labels = labelTxt.split('\n');
  }

  Future<void> runInference(List<List<List<num>>> imageMatrix) async {
    // Tensor input [1, 224, 224, 3]
    // 1, 960, 750, 1
    final input = [imageMatrix];
    // Tensor output [1, 1001]
    final output = [List<int>.filled(1001, 0)];

    // Run inference
    interpreter.run(input, output);

    // Get first output tensor
    final result = output.first;
  }
}

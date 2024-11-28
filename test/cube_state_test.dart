import 'package:flutter_test/flutter_test.dart';
import 'package:cy_cube/cube/cube_state.dart';

void main() {
  group('CubeState', () {
    test('initializes cube state correctly', () {
      final cubeState = CubeState();
      expect(CubeState.cubeModels.length, 27);
      expect(CubeState.indexWithStack.length, 27);
    });

    test('sets next move correctly', () {
      final cubeState = CubeState();
      cubeState.nextMove = 'U';

      expect(cubeState.nextMove, 'U');
    });

    test('rotates cube correctly', () {
      final cubeState = CubeState();
      cubeState.rotate(rotation: 'U');
    });
  });
}

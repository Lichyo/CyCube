import 'package:flutter/material.dart';

class CubeRotationTable extends StatelessWidget {
  const CubeRotationTable({super.key, required this.onPressed});

  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => onPressed('U'),
              child: const Text('U'),
            ),
            TextButton(
              onPressed: () => onPressed('D'),
              child: const Text('D'),
            ),
            TextButton(
              onPressed: () => onPressed('F'),
              child: const Text('F'),
            ),
            TextButton(
              onPressed: () => onPressed('B'),
              child: const Text('B'),
            ),
            TextButton(
              onPressed: () => onPressed('R'),
              child: const Text('R'),
            ),
            TextButton(
              onPressed: () => onPressed('L'),
              child: const Text('L'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => onPressed('U\''),
              child: const Text('U\''),
            ),
            TextButton(
              onPressed: () => onPressed('D\''),
              child: const Text('D\''),
            ),
            TextButton(
              onPressed: () => onPressed('F\''),
              child: const Text('F\''),
            ),
            TextButton(
              onPressed: () => onPressed('B\''),
              child: const Text('B\''),
            ),
            TextButton(
              onPressed: () => onPressed('R\''),
              child: const Text('R\''),
            ),
            TextButton(
              onPressed: () => onPressed('L\''),
              child: const Text('L\''),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  runApp(const TheCube());
}

class TheCube extends StatelessWidget {
  const TheCube({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
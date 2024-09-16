import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: Text('Course Page'),
          ),
        ),
      ],
    );
  }
}

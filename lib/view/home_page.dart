import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'open camera',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

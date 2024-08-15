import 'package:flutter/material.dart';

class LabPage extends StatefulWidget {
  const LabPage({super.key});

  @override
  State<LabPage> createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab'),
      ),
      body: const Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}

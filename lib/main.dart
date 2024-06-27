import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RubiksCube(),
      // home: Lab(),
    ),
  );
}

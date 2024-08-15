import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: RubiksCube(),
    ),
  );
}

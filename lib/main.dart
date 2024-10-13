import 'package:cy_cube/config.dart';
import 'package:cy_cube/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/service/auth_service.dart';
import 'package:cy_cube/view/route_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Config.initCamera();
  await AuthService().signOut();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CubeState(),
      child: MaterialApp(
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: true,
        home: AuthService.currentUser != null
            ? const RoutePage()
            : const WelcomePage(),
      ),
    ),
  );
}

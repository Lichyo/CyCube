import 'package:cube/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cube/service/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              FontAwesomeIcons.cube,
              size: 80.0,
              color: Color(0XFF607274),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Color(0XFF607274),
                ),
                label: const Text('Email '),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(
                  Icons.security,
                  color: Color(0XFF607274),
                ),
                label: const Text('Password '),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () async {
                  await _auth.login(email: _email, password: _password);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const RubiksCube()));
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.getFont(
                    'Open Sans',
                    fontSize: 20.0,
                    color: const Color(0XFF0F2167),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

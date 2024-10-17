import 'package:cy_cube/view/route_page.dart';
import 'package:cy_cube/components/email_password_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cy_cube/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/config.dart';
import 'package:lottie/lottie.dart';
import 'package:cy_cube/components/register_dialog.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CyCube'),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      // Lottie.network(
                      //   Config.lottieCubeAsset,
                      // ),
                      const Gap(30),
                      const Text('Welcome to CyCube'),
                      EmailPasswordForm(
                        onFormSubmit: (String email, String password) async {
                          setState(() {
                            _isLoading = true;
                          });
                          await AuthService().signInWithEmailAndPassword(
                              email: email, password: password);
                          setState(() {
                            _isLoading = false;
                          });
                          if (AuthService.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const RoutePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email/Password Sign In Failed'),
                              ),
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RegisterDialog(
                                onRegister: (String username, String email,
                                    String password) async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await AuthService()
                                      .signUpWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                    name: username,
                                  );
                                },
                              );
                            },
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          if (AuthService.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const RoutePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration Failed'),
                              ),
                            );
                          }
                        },
                        child: const Text('or register'),
                      ),
                      const MaxGap(100),
                      ElevatedButton(
                        onPressed: () async {
                          await AuthService().signInWithGoogle();
                          setState(() {
                            _isLoading = true;
                          });
                          if (AuthService.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const RoutePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google Sign In Failed'),
                              ),
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                            Gap(10),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const MaxGap(50),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

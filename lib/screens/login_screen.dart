import 'package:flutter/material.dart';

import '/resources/auth_methods.dart';

import '/widgets/custom_button.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start or join a meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset('assets/images/zoom-logo.jpg'),
          ),
          CustomButton(
            text: 'Google Sign In',
            onPressed: () {
              _authMethods.signInWithGoogle(
                context,
              ).then((value) {
                if (value == true) {
                  Navigator.of(context).pushReplacementNamed(
                    HomeScreen.routeName,
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

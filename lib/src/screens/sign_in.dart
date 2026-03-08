import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/guest_disclaimer.dart';
import 'package:flutter_app/src/screens/home.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TextField(), // Username
          const TextField(), // Password
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => const Home()));
            },
            child: const Text("Sign in"),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => const GuestDisclaimer()));
            },
            child: const Text("Continue as Guest"),
          ),
        ],
      ),
    );
  }
}

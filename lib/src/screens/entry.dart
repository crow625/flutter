import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/about.dart';
import 'package:flutter_app/src/screens/sign_in.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

class Entry extends StatelessWidget {
  const Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => const SignIn()));
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => const About()));
            },
            child: const Text('About'),
          ),
        ],
      ),
    );
  }
}

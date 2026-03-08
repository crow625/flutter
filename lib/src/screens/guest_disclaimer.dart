import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/home.dart';

class GuestDisclaimer extends StatelessWidget {
  const GuestDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              "When you use this app as a guest, your transactions will be saved locally on your phone. You will have the option of migrating to an account later."),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => const Home()));
            },
            child: const Text("Continue as Guest"),
          ),
        ],
      ),
    );
  }
}

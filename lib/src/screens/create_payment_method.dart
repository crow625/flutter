import 'package:flutter/material.dart';

class CreatePaymentMethod extends StatelessWidget {
  const CreatePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TextField(), // Name (text)
          TextButton(
            onPressed: () {},
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}

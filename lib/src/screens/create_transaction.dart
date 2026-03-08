import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

class CreateTransaction extends StatelessWidget {
  const CreateTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const TextField(), // Amount (number input)
          const TextField(), // Category (dropdown with option to create)
          const TextField(), // Payment Method (dropdown)
          const TextField(), // Notes (text)
          TextButton(
            onPressed: () {},
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}

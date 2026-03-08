import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

class CreatePaymentMethod extends StatelessWidget {
  const CreatePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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

import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

class NoRoute extends StatelessWidget {
  const NoRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("There's no screen here."),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Go back")),
        ],
      ),
    );
  }
}

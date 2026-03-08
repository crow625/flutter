import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: Text("This app lets you track your transactions."),
      ),
    );
  }
}

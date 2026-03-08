import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';

// Table view of transactions.
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Column(
        children: [
          Text("Transaction 1"),
          Text("Transaction 2"),
        ],
      ),
    );
  }
}

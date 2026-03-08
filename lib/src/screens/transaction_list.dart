import 'package:flutter/material.dart';

// Table view of transactions.
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Transaction 1"),
          Text("Transaction 2"),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';

class TransactionRow extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionRow(this.transaction, {super.key});

  String _formatAmount() {
    return '\$${(transaction.amountCents / 100).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Text(transaction.id.toString()),
        Text(transaction.vendor),
        Text(transaction.category),
        Text(_formatAmount()),
        Text(transaction.time.toIso8601String()),
      ],
    );
  }
}

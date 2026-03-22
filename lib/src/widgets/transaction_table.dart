import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_app/src/data/transactions.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/widgets/transaction_row.dart';

class TransactionTable extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionTable(this.transactions, {super.key});

  @Preview(
    name: 'TransactionTable',
    theme: previewThemeData,
  )
  TransactionTable.preview({super.key})
      : transactions = Transactions.transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((t) => TransactionRow(t)).toList(),
    );
  }
}

PreviewThemeData previewThemeData() {
  return PreviewThemeData(
    materialLight: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    materialDark: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
  );
}

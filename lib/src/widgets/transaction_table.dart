import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_app/src/data/transactions.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';

class TransactionTable extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionTable(this.transactions, {super.key});

  @Preview(
    name: 'TransactionTable',
    theme: previewThemeData,
  )
  TransactionTable.preview({super.key})
      : transactions = Transactions.transactions;

  String _formatAmount(TransactionModel t) {
    return '\$${(t.amountCents / 100).toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(60),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(90),
      },
      children: transactions
          .map(
            (t) => TableRow(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: BoxBorder.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(
                    _formatAmount(t),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    border: BoxBorder.symmetric(
                      vertical: BorderSide(),
                    ),
                  ),
                  child: Text(t.vendor),
                ),
                Text(
                  _formatDate(t.time),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

PreviewThemeData previewThemeData() {
  return PreviewThemeData(
    materialLight: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
  );
}

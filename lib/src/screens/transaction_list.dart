import 'package:flutter/material.dart';
import 'package:flutter_app/src/app/app.dart';
import 'package:flutter_app/src/transaction/transaction_provider.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';
import 'package:flutter_app/src/widgets/transaction_row.dart';
import 'package:provider/provider.dart';

// Table view of transactions.
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ChangeNotifierProvider(
        create: (context) => TransactionProvider($app.transactions),
        builder: (context, child) {
          final provider = Provider.of<TransactionProvider>(context);
          final transactions = provider.transactions;
          if (transactions.isEmpty) {
            return Column(
              children: [
                const Center(
                  child: Text("No transactions found."),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.getTransactions();
                  },
                  child: const Text("Refresh"),
                ),
              ],
            );
          }
          return Column(
            children: transactions.map((t) {
              return TransactionRow(t);
            }).toList(),
          );
        },
      ),
    );
  }
}

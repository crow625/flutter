import 'package:flutter/material.dart';
import 'package:flutter_app/src/transaction/transaction_provider.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';
import 'package:flutter_app/src/widgets/transaction_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);

    return AppScaffold(
      body: transactionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (transactions) => transactions.isEmpty
            ? const Center(child: Text('No transactions found.'))
            : Column(
                children: transactions.map((t) => TransactionRow(t)).toList(),
              ),
      ),
    );
  }
}

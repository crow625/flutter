import 'package:flutter/material.dart';
import 'package:flutter_app/src/sql/sql_error.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

enum TransactionProviderState {
  fetching,
  gotTransactions,
}

enum SortDirection {
  ascending,
  descending,
  none;
}

class TransactionProvider extends ChangeNotifier {
  final ITransactionRepository repo;

  TransactionProvider(this.repo);

  List<TransactionModel> transactions = [];
  SqlError? error;

  Future<void> getTransactions() async {
    final r = await repo.getTransactions();
    if (r.hasValue) {
      transactions = r.value!;
    } else {
      error = r.error;
    }
    notifyListeners();
  }
}

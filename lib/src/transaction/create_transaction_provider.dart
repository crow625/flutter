import 'package:flutter/material.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

class CreateTransactionProvider extends ChangeNotifier {
  final ITransactionRepository repo;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  CreateTransactionProvider(this.repo);

  dynamic error;

  Future<bool> createTransaction() async {
    final amountCents = int.tryParse(amountController.text);
    final notes = notesController.text;
    final time = DateTime.now();
    final paymentMethodId = 0;
    final category = 'unknown';
    final vendor = 'unknown';
    final userId = -1;

    if (amountCents == null) {
      throw StateError("Amount is not a number");
    }

    final t = TransactionModel.initial(
      userId: userId,
      amountCents: amountCents,
      category: category,
      vendor: vendor,
      paymentMethodId: paymentMethodId,
      notes: notes,
      time: time,
    );

    final r = await repo.createTransaction(t);

    if (r.isError) {
      error = r.error;
      return false;
    }

    return true;
  }
}

import 'package:flutter_app/src/transaction/transaction_model.dart';

final now = DateTime(2026, 2, 16, 17, 10, 0, 0, 0);

class Transactions {
  static final List<TransactionModel> transactions = [
    TransactionModel(
      id: 0,
      userId: 0,
      amountCents: 80000000,
      category: 'Groceries',
      vendor: 'Grocery Store',
      paymentMethodId: 0,
      notes: 'Pasta dinner',
      time: now,
    ),
    TransactionModel(
      id: 1,
      userId: 0,
      amountCents: 3644,
      category: 'Transport',
      vendor: 'Gas Station',
      paymentMethodId: 1,
      notes: 'gas',
      time: now,
    ),
    TransactionModel(
      id: 2,
      userId: 1,
      amountCents: 972,
      category: 'Entertainment',
      vendor: 'Movie Theater',
      paymentMethodId: 2,
      notes: 'movie ticket',
      time: now,
    ),
  ];
}

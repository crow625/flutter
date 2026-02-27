import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

// Planned commands:
// X createTransaction
// X getTransaction
// getTransactionsList
// updateTransaction
// createPaymentMethod
// getPaymentMethod
// getPaymentMethodsList
// updatePaymentMethod

class TransactionRepl {
  final ITransactionRepository repo;

  TransactionRepl(this.repo);

  Future<String> handleInput(String input) async {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      return "Please provide an input.";
    }

    final words = trimmed.split(' ');

    switch (words.first) {
      case 'createTransaction':
        if (words.length > 5) {
          final userId = int.tryParse(words[1]);
          final amountCents = int.tryParse(words[2]);
          final category = words[3];
          final paymentMethodId = int.tryParse(words[4]);
          final notes = words[5];
          DateTime time;
          if (words.length > 6) {
            final timeMillis = int.tryParse(words[6]);
            if (timeMillis != null) {
              time = DateTime.fromMillisecondsSinceEpoch(timeMillis);
            } else {
              time = DateTime.now();
            }
          } else {
            time = DateTime.now();
          }
          if (userId != null &&
              amountCents != null &&
              paymentMethodId != null) {
            final t = TransactionModel.initial(
              userId: userId,
              amountCents: amountCents,
              category: category,
              paymentMethodId: paymentMethodId,
              notes: notes,
              time: time,
            );
            final r = await repo.createTransaction(t);
            if (r.hasValue) {
              return 'Created transaction with id ${r.value!.id}';
            }
            return 'Failed to create transaction: ${r.error}';
          }
          return 'Failed to parse arguments';
        }
        return 'No arguments provided';
      case 'getTransaction':
        if (words.length > 1) {
          final id = int.tryParse(words[1]);
          if (id != null) {
            final r = await repo.getTransaction(id);
            if (r.hasValue) {
              return r.value!.toJson().toString();
            }
            return 'Error getting transaction: ${r.error}';
          }
          return 'Invalid id: $id';
        }
        return 'Provide a transaction id to retrieve';

      default:
        return 'Unrecognized command';
    }
  }
}

import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

//create
// get
// getList
// update
// delete

class TransactionRepl {
  final ITransactionRepository repo;

  TransactionRepl(this.repo);

  Future<String> handleInput(List<String> args) async {
    switch (args.first) {
      case 'create':
        if (args.length > 5) {
          final userId = int.tryParse(args[1]);
          final amountCents = int.tryParse(args[2]);
          final category = args[3];
          final paymentMethodId = int.tryParse(args[4]);
          final notes = args[5];
          DateTime time;
          if (args.length > 6) {
            final timeMillis = int.tryParse(args[6]);
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

      case 'get':
        if (args.length > 1) {
          final id = int.tryParse(args[1]);
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

      case 'list':
        final r = await repo.getTransactions();
        if (r.hasValue) {
          return r.value!.map((t) => t.toJson().toString()).join('\n');
        }
        return 'Error getting transactions: ${r.error}';

      case 'update':
        return 'Unsupported';

      case 'delete':
        if (args.length > 1) {
          final id = int.tryParse(args[1]);
          if (id != null) {
            final r = await repo.deleteTransaction(id);
            if (r.hasValue) {
              return 'Deleted ${r.value!} transactions';
            }
            return 'Failed to delete transaction: ${r.error}';
          }
          return 'Invalid id: $id';
        }
        return 'Provide a transaction id to delete';

      default:
        return 'Unrecognized command';
    }
  }
}

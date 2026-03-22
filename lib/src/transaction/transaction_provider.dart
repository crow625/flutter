import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<TransactionModel>>(
  TransactionsNotifier.new,
);

class TransactionsNotifier extends AsyncNotifier<List<TransactionModel>> {
  @override
  Future<List<TransactionModel>> build() async {
    final repo = ref.read(transactionRepositoryProvider);
    final result = await repo.getTransactions();
    if (result.hasError) throw result.error!;
    return result.value!;
  }
}

import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_provider.dart';
import 'package:flutter_app/src/transaction/transaction_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createTransactionProvider =
    AsyncNotifierProvider<CreateTransactionNotifier, void>(
  CreateTransactionNotifier.new,
);

class CreateTransactionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> createTransaction({
    required int amountCents,
    required String notes,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(transactionRepositoryProvider);
    final t = TransactionModel.initial(
      userId: -1,
      amountCents: amountCents,
      category: 'unknown',
      vendor: 'unknown',
      paymentMethodId: 0,
      notes: notes,
      time: DateTime.now(),
    );

    final r = await repo.createTransaction(t);
    if (r.isError) {
      state = AsyncError(r.error!, StackTrace.current);
      return;
    }

    state = const AsyncData(null);
    ref.invalidate(transactionsProvider);
  }
}

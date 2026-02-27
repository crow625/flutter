import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';

abstract interface class ITransactionRepository<E> {
  /// Create the transaction table.
  Future<Result<void, E>> createTable();

  /// Create a new transaction.
  ///
  /// It is expected that the supplied TransactionModel will use [TransactionModelId.none] for its id.
  /// The returned [TransactionModel] will use the id assigned by the database.
  Future<Result<TransactionModel, E>> createTransaction(TransactionModel t);

  /// Get all transactions that meet the supplied parameters.
  ///
  /// - [userId] - Include only transactions for this userId.
  /// - [startDate] - Include only transactions after this date.
  /// - [endDate] - Include only transactions before this date.
  Future<Result<List<TransactionModel>, E>> getTransactions({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get the transaction with the specified ID.
  Future<Result<TransactionModel, E>> getTransaction(int id);

  /// Update a transaction with new parameters.
  ///
  /// The change will be applied to the transaction with the matching id.
  Future<Result<int, E>> updateTransaction(TransactionModel t);

  /// Delete the transaction with the provided id.
  Future<Result<int, E>> deleteTransaction(int id);
}

import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/sql/sql_database.dart';
import 'package:flutter_app/src/sql/sql_error.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

class SqlTransactionRepository implements ITransactionRepository<SqlError> {
  final String tableName;
  final ISqlDatabase<TransactionModel> db;

  const SqlTransactionRepository(this.db, {this.tableName = 'transactions'});

  @override
  Future<Result<void, SqlError>> createTable() async {
    try {
      return await db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, user_id INTEGER PRIMARY KEY, amount_cents INTEGER, category TEXT, payment_method_id INTEGER, notes TEXT, datetime TEXT)");
    } catch (e) {
      return const Result.error(SqlError('Failed to create table.'));
    }
  }

  @override
  Future<Result<List<TransactionModel>, SqlError>> getTransactions({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    // userId != null:
    // WHERE user_id = {userId}

    // startDate != null:
    // WHERE time > {startDate}

    // endDate != null:
    // WHERE time < {endDate}

    return db.query(tableName);
  }
}

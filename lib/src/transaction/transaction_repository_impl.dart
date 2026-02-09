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

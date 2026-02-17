import 'package:flutter_app/src/generic/date_time_converter.dart';
import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/sql/sql_database.dart';
import 'package:flutter_app/src/sql/sql_error.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';

class SqlTransactionRepository implements ITransactionRepository<SqlError> {
  final String tableName;
  final ISqlDatabase<Map<String, Object?>> db;

  const SqlTransactionRepository(this.db, {this.tableName = 'transactions'});

  @override
  Future<Result<void, SqlError>> createTable() async {
    try {
      return await db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, user_id INTEGER PRIMARY KEY, amount_cents INTEGER, category TEXT, payment_method_id INTEGER, notes TEXT, time INTEGER)");
    } catch (e) {
      return Result.error(SqlError('Failed to create table: $e'));
    }
  }

  @override
  Future<Result<TransactionModel, SqlError>> createTransaction(
      TransactionModel t) async {
    try {
      final r = await db.insert(tableName, t.toJson());
      if (r.hasValue) {
        final id = r.value!;
        return Result.success(t.copyWith(id: id));
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to create transaction: $e'));
    }
  }

  @override
  Future<Result<List<TransactionModel>, SqlError>> getTransactions({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final where = <String>[];
      final whereArgs = <Object?>[];

      if (userId != null) {
        where.add('user_id = ?');
        whereArgs.add(userId);
      }

      if (startDate != null) {
        where.add('time > ?');
        whereArgs.add(const DateTimeMillisConverter().toJson(startDate));
      }

      if (endDate != null) {
        where.add('time < ?');
        whereArgs.add(const DateTimeMillisConverter().toJson(endDate));
      }

      final r = await db.query(tableName,
          where: where.join(', '), whereArgs: whereArgs);
      if (r.hasValue) {
        final rows = r.value!.map((t) => TransactionModel.fromJson(t)).toList();
        return Result.success(rows);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to get transactions: $e'));
    }
  }

  @override
  Future<Result<int, SqlError>> updateTransaction(TransactionModel t) async {
    try {
      final r = await db
          .update(tableName, t.toJson(), where: 'id = ?', whereArgs: [t.id]);
      if (r.hasValue) {
        return Result.success(r.value!);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to update transaction: $e'));
    }
  }

  @override
  Future<Result<int, SqlError>> deleteTransaction(int id) async {
    try {
      final r = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      if (r.hasValue) {
        return Result.success(r.value!);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to delete transaction: $e'));
    }
  }
}

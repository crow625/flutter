import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/payment_method/payment_method_model.dart';
import 'package:flutter_app/src/payment_method/payment_method_repository.dart';
import 'package:flutter_app/src/sql/sql_database.dart';
import 'package:flutter_app/src/sql/sql_error.dart';

class SqlPaymentMethodRepository implements IPaymentMethodRepository<SqlError> {
  final String tableName;
  final ISqlDatabase<Map<String, Object?>> db;

  const SqlPaymentMethodRepository(this.db,
      {this.tableName = 'payment_methods'});

  @override
  Future<Result<void, SqlError>> createTable() async {
    try {
      return await db.execute(
          "CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY, user_id INTEGER, name TEXT)");
    } catch (e) {
      return Result.error(SqlError('Failed to create table: $e'));
    }
  }

  @override
  Future<Result<PaymentMethodModel, SqlError>> createPaymentMethod(
      PaymentMethodModel p) async {
    try {
      final r = await db.insert(tableName, p.toJson()..remove('id'));
      if (r.hasValue) {
        final id = r.value!;
        return Result.success(p.copyWith(id: id));
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to create payment method: $e'));
    }
  }

  @override
  Future<Result<List<PaymentMethodModel>, SqlError>> getPaymentMethods(
      {String? userId}) async {
    try {
      final where = <String>[];
      final whereArgs = <Object?>[];

      if (userId != null) {
        where.add('user_id = ?');
        whereArgs.add(userId);
      }

      final r = await db.query(
        tableName,
        where: where.isEmpty ? null : where.join(', '),
        whereArgs: whereArgs.isEmpty ? null : whereArgs,
      );
      if (r.hasValue) {
        final rows =
            r.value!.map((t) => PaymentMethodModel.fromJson(t)).toList();
        return Result.success(rows);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to get payment methods: $e'));
    }
  }

  @override
  Future<Result<PaymentMethodModel, SqlError>> getPaymentMethod(int id) async {
    try {
      final r = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
      if (r.hasValue) {
        if (r.value!.isNotEmpty) {
          final p = PaymentMethodModel.fromJson(r.value!.first);
          return Result.success(p);
        } else {
          return Result.error(
              SqlError('Payment method with id $id not found.'));
        }
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to get payment method: $e'));
    }
  }

  @override
  Future<Result<int, SqlError>> updatePaymentMethod(
      PaymentMethodModel p) async {
    try {
      final r = await db
          .update(tableName, p.toJson(), where: 'id = ?', whereArgs: [p.id]);
      if (r.hasValue) {
        return Result.success(r.value!);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to update payment method: $e'));
    }
  }

  @override
  Future<Result<int, SqlError>> deletePaymentMethod(int id) async {
    try {
      final r = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      if (r.hasValue) {
        return Result.success(r.value!);
      }
      return Result.error(r.error);
    } catch (e) {
      return Result.error(SqlError('Failed to delete payment method: $e'));
    }
  }
}

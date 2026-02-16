import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/sql/sql_error.dart';

abstract interface class ISqlDatabase<T> {
  Future<Result<void, SqlError>> init();

  Future<Result<int, SqlError>> insert(String tableName, T values);

  Future<Result<void, SqlError>> execute(String sql,
      [List<Object?>? arguments]);

  Future<Result<List<T>, SqlError>> query(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });

  Future<Result<void, SqlError>> dispose();

  Future<Result<void, SqlError>> destroy();
}

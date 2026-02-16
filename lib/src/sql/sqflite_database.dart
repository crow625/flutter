import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/sql/sql_database.dart';
import 'package:flutter_app/src/sql/sql_error.dart';
import 'package:sqflite/sqflite.dart';

const _notInitialized = SqlError("Database not initialized.");

class SqfliteDatabase implements ISqlDatabase<Map<String, Object?>> {
  final String path;
  late final Database db;

  bool _initialized = false;

  SqfliteDatabase(this.path);

  @override
  Future<Result<void, SqlError>> dispose() async {
    if (!_initialized) return const Result.error(_notInitialized);
    try {
      await db.close();
      return const Result.success(null);
    } catch (e) {
      return Result.error(SqlError("Failed to close database: $e"));
    }
  }

  @override
  Future<Result<void, SqlError>> execute(String sql,
      [List<Object?>? arguments]) async {
    if (!_initialized) return const Result.error(_notInitialized);
    try {
      await db.execute(sql, arguments);
      return const Result.success(null);
    } catch (e) {
      return Result.error(SqlError("Failed to execute: $e"));
    }
  }

  @override
  Future<Result<void, SqlError>> init() async {
    if (_initialized) {
      return const Result.error(SqlError("Database already initialized."));
    }
    try {
      db = await openDatabase(path);
      _initialized = true;
      return const Result.success(null);
    } catch (e) {
      return Result.error(SqlError("Failed to initialize database: $e"));
    }
  }

  @override
  Future<Result<int, SqlError>> insert(
      String tableName, Map<String, Object?> values) async {
    if (!_initialized) return const Result.error(_notInitialized);
    try {
      final id = await db.insert(tableName, values);
      return Result.success(id);
    } catch (e) {
      return Result.error(SqlError("Failed to insert: $e"));
    }
  }

  @override
  Future<Result<List<Map<String, Object?>>, SqlError>> query(
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
  }) async {
    if (!_initialized) return const Result.error(_notInitialized);
    try {
      final values = await db.query(
        tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      return Result.success(values);
    } catch (e) {
      return Result.error(SqlError("Failed to query: $e"));
    }
  }

  @override
  Future<Result<void, SqlError>> destroy() async {
    try {
      await deleteDatabase(path);
      return const Result.success(null);
    } catch (e) {
      return Result.error(SqlError("Failed to destroy db: $e"));
    }
  }
}

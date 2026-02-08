import 'package:flutter_app/src/sql/sql_service.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository extends SqlService {
  static String get tableName => 'transactions';
  static String get dbFilePath => 'transactions_database.db';

  Future<void> onCreate(Database db, int version) async {
    return db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, user_id INTEGER PRIMARY KEY, amount_cents INTEGER, category TEXT, payment_method_id INTEGER, notes TEXT, datetime TEXT)");
  }

  /// Insert a new transaction into the database.
  Future<void> insertTransaction(TransactionModel t) async {
    await db.insert(
      tableName,
      t.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all transactions in the database.
  Future<List<TransactionModel>> getTransactions() async {
    final List<Map<String, Object?>> rows = await db.query(tableName);

    return rows.map((r) => TransactionModel.fromJson(r)).toList();
  }

  /// Update a transaction in the database.
  Future<void> updateDog(TransactionModel t) async {
    await db.update(
      tableName,
      t.toJson(),
      // Ensure we replace the entry with the same id.
      where: 'id = ?',
      // Arguments to populate in the where clause.
      whereArgs: [t.id],
    );
  }

  /// Delete the transaction with the given id from the database.
  Future<void> deleteDog(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

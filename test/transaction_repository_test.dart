import 'package:flutter_app/src/sql/sqflite_database.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';
import 'package:flutter_app/src/transaction/transaction_repository_sql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const _dbName = 'transactions.db';
const _tableName = 'transactions';
final now = DateTime(2026, 2, 16, 17, 10, 0, 0, 0);

TransactionModel initialFactory() {
  return TransactionModel.initial(
    userId: 0,
    amountCents: 100,
    category: 'Groceries',
    paymentMethodId: 0,
    notes: 'Pasta dinner',
    time: now,
  );
}

void main() async {
  late SqfliteDatabase db;
  late SqlTransactionRepository repo;

  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    db = SqfliteDatabase(_dbName, version: 1);
    repo = SqlTransactionRepository(db, tableName: _tableName);
    final r = await db.init();
    expect(r.error, isNull);

    final r2 = await repo.createTable();
    expect(r2.error, isNull);
  });

  tearDown(() async {
    await db.dispose();
    await db.destroy();
  });

  test('create + get', () async {
    var model = initialFactory();
    final r = await repo.createTransaction(model);
    expect(r.error, isNull);
    model = r.value!;

    final r2 = await repo.getTransactions();
    expect(r2.error, isNull);

    final transactions = r2.value!;
    expect(transactions.length, 1);

    final t = transactions.first;
    expect(t.id, model.id);
  });

  test('update', () async {
    var model = initialFactory();
    final r = await repo.createTransaction(model);
    expect(r.error, isNull);
    model = r.value!;

    final newModel = model.copyWith(notes: 'Pasta lunch');
    final r2 = await repo.updateTransaction(newModel);
    expect(r2.error, isNull);
    expect(r2.value, 1);
  });

  test('delete', () async {
    var model = initialFactory();
    final r = await repo.createTransaction(model);
    expect(r.error, isNull);
    model = r.value!;

    final r2 = await repo.deleteTransaction(model.id);
    expect(r2.error, isNull);
    expect(r2.value!, 1);
  });
}

import 'package:flutter_app/src/sql/sqflite_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const _dbName = 'sqflite.db';
const _tableName = 'test';

void main() async {
  late SqfliteDatabase db;

  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    db = SqfliteDatabase(_dbName);
    final r = await db.init();
    expect(r.error, isNull);
  });

  tearDown(() async {
    await db.dispose();
    await db.destroy();
  });

  test('create table', () async {
    await db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY)');
    await db.insert(_tableName, {'id': 0});
    final r = await db.query(_tableName);

    expect(r.error, isNull);
    expect(r.value, [
      {'id': 0}
    ]);
  });

  group('query', () {
    const tableName = 'query_test';

    setUp(() async {
      final r = await db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, value INTEGER)');
      expect(r.error, null);

      var r2 = await db.insert(tableName, {'id': 0, 'value': 10});
      expect(r2.error, null);
      r2 = await db.insert(tableName, {'id': 1, 'value': 20});
      expect(r2.error, null);
      r2 = await db.insert(tableName, {'id': 2, 'value': 30});
      expect(r2.error, null);
    });

    test('where', () async {
      var r = await db.query(tableName, where: 'value > ?', whereArgs: [15]);
      expect(r.error, isNull);
      expect(r.value, [
        {'id': 1, 'value': 20},
        {'id': 2, 'value': 30},
      ]);
    });

    test('columns', () async {
      var r = await db.query(tableName, columns: ['value']);
      expect(r.error, isNull);
      expect(r.value, [
        {'value': 10},
        {'value': 20},
        {'value': 30},
      ]);
    });

    test('orderBy', () async {
      var r = await db.query(tableName, orderBy: 'value DESC');
      expect(r.error, isNull);
      expect(r.value, [
        {'id': 2, 'value': 30},
        {'id': 1, 'value': 20},
        {'id': 0, 'value': 10},
      ]);
    });

    test('limit', () async {
      var r = await db.query(tableName, limit: 1);
      expect(r.error, isNull);
      expect(r.value, [
        {'id': 0, 'value': 10},
      ]);
    });

    test('offset', () async {
      var r = await db.query(tableName, offset: 1);
      expect(r.error, isNull);
      expect(r.value, [
        {'id': 1, 'value': 20},
        {'id': 2, 'value': 30},
      ]);
    });
  });
}

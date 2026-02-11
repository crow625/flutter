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
}

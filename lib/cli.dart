import 'dart:io';

import 'package:flutter_app/src/sql/sqflite_database.dart';
import 'package:flutter_app/src/transaction/transaction_repl.dart';
import 'package:flutter_app/src/transaction/transaction_repository_sql.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  var canceled = false;
  final sub = ProcessSignal.sigint.watch().listen((s) {
    print("SIGINT");
    canceled = true;
  });
  const dbName = 'transactions.db';
  const tableName = 'transactions';

  final SqfliteDatabase db;
  final SqlTransactionRepository repo;

  databaseFactory = databaseFactoryFfi;

  db = SqfliteDatabase(dbName, version: 1);
  repo = SqlTransactionRepository(db, tableName: tableName);
  final r = await db.init();
  if (r.hasError) {
    print("Error initializing database: ${r.error}");
    return;
  }

  final r2 = await repo.createTable();
  if (r.hasError) {
    print("Error creating table: ${r2.error}");
  }

  final repl = TransactionRepl(repo);

  print("Enter a command:");
  while (!canceled) {
    final line = stdin.readLineSync();
    if (line != null) {
      final output = await repl.handleInput(line);
      print(output);
    } else {
      print("Bye bye");
      break;
    }
  }

  await sub.cancel();
}

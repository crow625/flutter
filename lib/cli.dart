import 'dart:io';

import 'package:flutter_app/src/payment_method/payment_method_repl.dart';
import 'package:flutter_app/src/payment_method/payment_method_repository_sql.dart';
import 'package:flutter_app/src/sql/sqflite_database.dart';
import 'package:flutter_app/src/transaction/transaction_repl.dart';
import 'package:flutter_app/src/transaction/transaction_repository_sql.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  const dbName = 'transactions.db';
  const pDbName = 'paymentMethods.db';
  const tableName = 'transactions';
  const pTableName = 'payment_methods';

  final SqfliteDatabase db;
  final SqfliteDatabase pDb;
  final SqlTransactionRepository repo;
  final SqlPaymentMethodRepository pRepo;

  databaseFactory = databaseFactoryFfi;

  db = SqfliteDatabase(dbName, version: 1);
  pDb = SqfliteDatabase(pDbName, version: 1);
  repo = SqlTransactionRepository(db, tableName: tableName);
  pRepo = SqlPaymentMethodRepository(pDb, tableName: pTableName);
  final r = await db.init();
  if (r.hasError) {
    print("Error initializing database: ${r.error}");
    return;
  }

  final r2 = await repo.createTable();
  if (r.hasError) {
    print("Error creating table: ${r2.error}");
    return;
  }

  final r3 = await pDb.init();
  if (r3.hasError) {
    print("Error initializing database: ${r3.error}");
    return;
  }

  final r4 = await pRepo.createTable();
  if (r4.hasError) {
    print("Error creating table: ${r4.error}");
    return;
  }

  final repl = TransactionRepl(repo);
  final pRepl = PaymentMethodRepl(pRepo);

  print("Enter a command:");
  while (true) {
    final line = stdin.readLineSync();
    if (line != null) {
      if (['q', 'quit', 'exit'].contains(line.trim())) {
        print("Bye bye");
        break;
      }
      final words = line.trim().split(' ');
      if (words.isNotEmpty) {
        if (words.first == 'transaction') {
          final output = await repl.handleInput(words.sublist(1));
          print(output);
        } else if (words.first == 'paymentMethod') {
          final output = await pRepl.handleInput(words.sublist(1));
          print(output);
        }
      } else {
        print("Please enter a command.");
      }
    } else {
      print("Bye bye");
      break;
    }
  }
}

import 'package:flutter_app/src/app/app_config.dart';
import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/payment_method/payment_method_repository_sql.dart';
import 'package:flutter_app/src/sql/sqflite_database.dart';
import 'package:flutter_app/src/transaction/transaction_repository_sql.dart';

late TransactionApp $app;

class TransactionApp {
  final TransactionAppConfig config;
  late final SqfliteDatabase db;
  late final SqlTransactionRepository transactions;
  late final SqlPaymentMethodRepository paymentMethods;

  TransactionApp(this.config);

  Future<Result<void, dynamic>> init() async {
    db = SqfliteDatabase(config.dbPath, version: config.dbVersion);
    final r = await db.init();
    if (r.isError) {
      return Result.error(r.error);
    }
    transactions =
        SqlTransactionRepository(db, tableName: config.transactionTableName);
    paymentMethods = SqlPaymentMethodRepository(db,
        tableName: config.paymentMethodTableName);

    final r2 = await Future.wait([
      transactions.createTable(),
      paymentMethods.createTable(),
    ]);

    for (final r in r2) {
      if (r.isError) {
        return Result.error(r.error);
      }
    }

    return const Result.success(null);
  }
}

import 'package:flutter_app/src/app/app.dart';
import 'package:flutter_app/src/sql/sql_error.dart';
import 'package:flutter_app/src/transaction/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider =
    Provider<ITransactionRepository<SqlError>>((ref) => $app.transactions);

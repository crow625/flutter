import 'dart:async';

import 'package:flutter_app/src/sql/sql_database.dart';

class AppDbUpgrade {
  static FutureOr<void> onTransactionDbVersionChange(
      ISqlDatabase db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) _handleUpgrade(db, oldVersion, newVersion);
    if (oldVersion > newVersion) _handleDowngrade(db, oldVersion, newVersion);
  }
}

FutureOr<void> _handleUpgrade(
    ISqlDatabase db, int oldVersion, int newVersion) async {
  if (oldVersion == 1 && newVersion > 1) {
    db.execute("ALTER TABLE transactions ADD vendor TEXT;");
  }
}

FutureOr<void> _handleDowngrade(
    ISqlDatabase db, int oldVersion, int newVersion) async {}

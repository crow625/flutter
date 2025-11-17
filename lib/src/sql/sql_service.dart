import 'package:flutter_app/src/app/app_args.dart';
import 'package:flutter_app/src/app/app_service.dart';
import 'package:sqflite/sqflite.dart';

class SqlService implements AppService {
  late final String path;
  late final Database db;

  @override
  Future<void> init(AppArgs args) async {
    if (!args.useSql) return;

    path = args.sqlPath;
    db = await openDatabase(path);
  }

  Future<void> createTable(String name) async {
    // db.execute(sql)
  }

  @override
  Future<void> dispose() async {
    await db.close();
  }
}
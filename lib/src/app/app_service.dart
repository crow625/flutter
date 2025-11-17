import 'package:flutter_app/src/app/app_args.dart';

abstract class AppService {
  Future<void> init(AppArgs args);
  Future<void> dispose();
}
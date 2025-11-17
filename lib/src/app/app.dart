import 'package:flutter_app/src/app/app_args.dart';
import 'package:flutter_app/src/app/app_service.dart';

class App {
  App._();

  static final App _instance = App._();

  /// The app instance.
  App get I => _instance;

  AppArgs? _args;

  final Set<AppService> _services = {};

  void init(AppArgs args) {
    _args = args;
  }

  Future<void> initService(AppService service) async {
    _assertInitialized();
    _services.add(service);
    await service.init(_args!);
  }

  Future<void> dispose() async {
    _assertInitialized();
    await Future.wait(_services.map((s) => s.dispose()));
  }

  void _assertInitialized() {
    if (_args == null) {
      throw Exception("App not initialized!");
    }
  }
}

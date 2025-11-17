class App {
  App._();

  static final App _instance = App._();

  /// The app instance.
  App get I => _instance;
}

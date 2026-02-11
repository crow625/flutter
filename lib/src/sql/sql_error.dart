class SqlError {
  final String message;

  const SqlError(this.message);

  @override
  String toString() {
    return 'SqlError($message)';
  }
}

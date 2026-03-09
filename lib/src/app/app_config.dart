class TransactionAppConfig {
  final String dbPath;
  final int dbVersion;
  final String transactionTableName;
  final String paymentMethodTableName;

  const TransactionAppConfig({
    required this.dbPath,
    required this.dbVersion,
    required this.transactionTableName,
    required this.paymentMethodTableName,
  });
}

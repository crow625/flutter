enum SqlDataType {
  /// NULL
  nullType("NULL"),

  /// 0, 1, 2, 3, 4, 6, or 8 byte integer
  integer("INTEGER"),

  /// 8-byte float
  real("REAL"),

  /// Text string
  text("TEXT"),

  /// Blob of data, stored exactly as it was input.
  blob("BLOB");

  final String value;
  const SqlDataType(this.value);
}

class SqlColumn {
  final String name;
  final SqlDataType dataType;
  final bool isPrimaryKey;

  const SqlColumn({
    required this.name,
    required this.dataType,
    required this.isPrimaryKey,
  });
}

class SqlTable {
  final String tableName;
  final List<SqlColumn> columns;

  const SqlTable({
    required this.tableName,
    required this.columns,
  });

  bool validate() {
    return columns.any((e) => e.isPrimaryKey);
  }
}

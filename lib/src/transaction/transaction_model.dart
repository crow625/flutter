class TransactionModel {
  final int id;
  final int userId;
  final int amountCents;
  final String category;
  final int paymentMethodId;
  final String notes;
  final String time;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amountCents,
    required this.category,
    required this.paymentMethodId,
    required this.notes,
    required this.time,
  });

  DateTime get timeAsDatetime => DateTime.parse(time);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount_cents': amountCents,
      'category': category,
      'payment_method_id': paymentMethodId,
      'notes': notes,
      'datetime': time,
    };
  }
}

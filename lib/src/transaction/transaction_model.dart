import 'package:flutter_app/src/generic/date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

class TransactionModelId {
  static const none = -1;
}

@JsonSerializable()
class TransactionModel {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'amount_cents')
  final int amountCents;

  final String category;

  final String vendor;

  @JsonKey(name: 'payment_method_id')
  final int paymentMethodId;

  final String notes;

  @DateTimeMillisConverter()
  final DateTime time;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amountCents,
    required this.category,
    required this.vendor,
    required this.paymentMethodId,
    required this.notes,
    required this.time,
  });

  const TransactionModel.initial({
    required this.userId,
    required this.amountCents,
    required this.category,
    required this.vendor,
    required this.paymentMethodId,
    required this.notes,
    required this.time,
  }) : id = TransactionModelId.none;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);

  Map<String, Object?> toJson() => _$TransactionModelToJson(this);

  TransactionModel copyWith({
    int? id,
    int? userId,
    int? amountCents,
    String? category,
    String? vendor,
    int? paymentMethodId,
    String? notes,
    DateTime? time,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amountCents: amountCents ?? this.amountCents,
      category: category ?? this.category,
      vendor: vendor ?? this.vendor,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      notes: notes ?? this.notes,
      time: time ?? this.time,
    );
  }
}

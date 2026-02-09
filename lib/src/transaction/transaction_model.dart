import 'package:flutter_app/src/generic/date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'amount_cents')
  final int amountCents;

  final String category;

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
    required this.paymentMethodId,
    required this.notes,
    required this.time,
  });

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);

  Map<String, Object?> toJson() => _$TransactionModelToJson(this);
}

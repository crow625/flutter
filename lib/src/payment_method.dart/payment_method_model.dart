import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  final String name;

  const PaymentMethodModel({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory PaymentMethodModel.fromJson(Map<String, Object?> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, Object?> toJson() => _$PaymentMethodModelToJson(this);
}

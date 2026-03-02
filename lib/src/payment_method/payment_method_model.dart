import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

class PaymentMethodModelId {
  static const none = -1;
}

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

  const PaymentMethodModel.initial({
    required this.userId,
    required this.name,
  }) : id = PaymentMethodModelId.none;

  factory PaymentMethodModel.fromJson(Map<String, Object?> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, Object?> toJson() => _$PaymentMethodModelToJson(this);

  PaymentMethodModel copyWith({
    int? id,
    int? userId,
    String? name,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}

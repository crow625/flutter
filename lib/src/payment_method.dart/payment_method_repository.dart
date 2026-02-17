import 'package:flutter_app/src/generic/result.dart';
import 'package:flutter_app/src/payment_method.dart/payment_method_model.dart';

abstract interface class IPaymentMethodRepository<E> {
  /// Create the payment method table.
  Future<Result<void, E>> createTable();

  /// Create a new payment method.
  ///
  /// It is expected that the supplied PaymentMethodModel will use [PaymentMethodModelId.none] for its id.
  /// The returned [PaymentMethodModel] will use the id assigned by the database.
  Future<Result<PaymentMethodModel, E>> createPaymentMethod(
      PaymentMethodModel t);

  /// Get all payment methods that meet the supplied parameters.
  ///
  /// - [userId] - Include only payment methods for this userId.
  Future<Result<List<PaymentMethodModel>, E>> getPaymentMethods(
      {String? userId});

  /// Update a payment method with new parameters.
  ///
  /// The change will be applied to the payment method with the matching id.
  Future<Result<int, E>> updatePaymentMethod(PaymentMethodModel t);

  /// Delete the payment method with the provided id.
  Future<Result<int, E>> deletePaymentMethod(int id);
}

import 'package:flutter_app/src/payment_method/payment_method_model.dart';
import 'package:flutter_app/src/payment_method/payment_method_repository.dart';

// create <userId> <name>
// get <id>
// list
// update
// delete <id>

class PaymentMethodRepl {
  final IPaymentMethodRepository repo;

  PaymentMethodRepl(this.repo);

  Future<String> handleInput(List<String> args) async {
    if (args.isEmpty) {
      return "Please provide an input.";
    }

    switch (args.first) {
      case 'create':
        if (args.length > 2) {
          final userId = int.tryParse(args[1]);
          final name = args[2];

          if (userId != null) {
            final p = PaymentMethodModel.initial(userId: userId, name: name);
            final r = await repo.createPaymentMethod(p);
            if (r.hasValue) {
              return 'Created payment method with id ${r.value!.id}';
            }
            return 'Failed to create payment method: ${r.error}';
          }
          return 'Failed to parse arguments';
        }
        return 'No arguments provided';
      case 'get':
        if (args.length > 1) {
          final id = int.tryParse(args[1]);
          if (id != null) {
            final r = await repo.getPaymentMethod(id);
            if (r.hasValue) {
              return r.value!.toJson().toString();
            }
            return 'Error getting payment method: ${r.error}';
          }
          return 'Invalid id: $id';
        }
        return 'Provide a payment method id to retrieve';

      case 'list':
        final r = await repo.getPaymentMethods();
        if (r.hasValue) {
          return r.value!.map((p) => p.toJson().toString()).join('\n');
        }
        return 'Error getting payment methods: ${r.error}';

      case 'update':
        return 'Unsupported';

      case 'delete':
        if (args.length > 1) {
          final id = int.tryParse(args[1]);
          if (id != null) {
            final r = await repo.deletePaymentMethod(id);
            if (r.hasValue) {
              return 'Deleted ${r.value!} payment methods';
            } else {
              return "Failed to delete payment methods: ${r.error}";
            }
          }
          return "Invalid id: $id";
        }
        return 'Provide a payment method id to delete';

      default:
        return 'Unrecognized command';
    }
  }
}

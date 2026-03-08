import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/create_payment_method.dart';
import 'package:flutter_app/src/screens/create_transaction.dart';
import 'package:flutter_app/src/screens/transaction_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => const CreateTransaction()));
            },
            child: const Text('Create a transaction'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => const TransactionList()));
            },
            child: const Text('View transactions'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => const CreatePaymentMethod()));
            },
            child: const Text('Manage payment methods'),
          ),
        ],
      ),
    );
  }
}

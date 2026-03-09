import 'package:flutter/material.dart';
import 'package:flutter_app/src/app/app.dart';
import 'package:flutter_app/src/transaction/create_transaction_provider.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';
import 'package:provider/provider.dart';

class CreateTransaction extends StatelessWidget {
  const CreateTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ChangeNotifierProvider(
          create: (context) => CreateTransactionProvider($app.transactions),
          builder: (context, child) {
            final provider = Provider.of<CreateTransactionProvider>(context);
            return Column(
              children: [
                // Amount (number input)
                TextField(
                  controller: provider.amountController,
                  keyboardType: TextInputType.number,
                ),
                // const TextField(), // Category (dropdown with option to create)
                // const TextField(), // Payment Method (dropdown)
                // Notes (text)
                TextField(
                  controller: provider.notesController,
                ),
                TextButton(
                  onPressed: () async {
                    final r = await provider.createTransaction();
                    if (r) {
                      print("SUCCESS");
                    } else {
                      print("FAILED");
                    }
                  },
                  child: const Text("Create"),
                ),
              ],
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/src/transaction/create_transaction_provider.dart';
import 'package:flutter_app/src/widgets/scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTransaction extends ConsumerStatefulWidget {
  const CreateTransaction({super.key});

  @override
  ConsumerState<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends ConsumerState<CreateTransaction> {
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createTransactionProvider);
    final isLoading = createState is AsyncLoading;

    return AppScaffold(
      body: Column(
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          // Category (dropdown)
          // Payment method (dropdown)
          TextField(
            controller: _notesController,
          ),
          if (createState is AsyncError) Text('Error: ${createState.error}'),
          TextButton(
            onPressed: isLoading
                ? null
                : () async {
                    final amountCents = int.tryParse(_amountController.text);
                    if (amountCents == null) return;
                    await ref
                        .read(createTransactionProvider.notifier)
                        .createTransaction(
                          amountCents: amountCents,
                          notes: _notesController.text,
                        );
                    if (context.mounted &&
                        ref.read(createTransactionProvider) is AsyncData) {
                      Navigator.pop(context);
                    }
                  },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

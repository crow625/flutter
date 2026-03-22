import 'package:flutter/material.dart';
import 'package:flutter_app/src/transaction/transaction_model.dart';

class TransactionRow extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionRow(this.transaction, {super.key});

  String _formatAmount() {
    return '\$${(transaction.amountCents / 100).toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDate(transaction.time),
                style: textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                transaction.vendor,
                style: textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            _formatAmount(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

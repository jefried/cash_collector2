import 'package:cash_collector/composants/history_transaction.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/models/history_transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsHistory extends StatelessWidget {

  final List<HistoryTransactionItem> transactionsHist;
  const TransactionsHistory({
    Key? key,
    required this.transactionsHist
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        shrinkWrap: false,
        children: transactionsHist.map(
          (transaction) => HistoryTransaction(
              success: transaction.success,
              dateTime: transaction.dateTime,
              amount: transaction.amount,
              imagePath: transaction.logoPath,
              typeTransaction: transaction.typeTransaction
          )
        ).toList(),
      ),
    );
  }
}

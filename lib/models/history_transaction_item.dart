class HistoryTransactionItem {
  bool success;
  String typeTransaction;
  num amount;
  String logoPath;
  DateTime dateTime;

  HistoryTransactionItem({
    required this.amount,
    required this.dateTime,
    required this.success,
    required this.logoPath,
    required this.typeTransaction
  });
}
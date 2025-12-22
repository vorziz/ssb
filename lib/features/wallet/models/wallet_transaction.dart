enum WalletTransactionType { debit, credit }

class WalletTransaction {
  final String id;
  final WalletTransactionType type;
  final int amount;
  final DateTime date;
  final String description;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });
}

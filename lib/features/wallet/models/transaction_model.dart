class TransactionModel {
  final String id;
  final String description;
  final int amount;
  final String type;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}

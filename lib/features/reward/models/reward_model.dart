class RewardModel {
  final String id;
  final String title;
  final DateTime expiryDate;
  bool isClaimed;

  RewardModel({
    required this.id,
    required this.title,
    required this.expiryDate,
    this.isClaimed = false,
  });
}

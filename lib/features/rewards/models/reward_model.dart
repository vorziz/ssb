class RewardModel {
  final String id;
  final String title;
  final DateTime expiryDate;
  bool isClaimed;
  DateTime? claimedAt;

  RewardModel({
    required this.id,
    required this.title,
    required this.expiryDate,
    this.isClaimed = false,
    this.claimedAt,
  });

  Duration get timeRemaining {
    return expiryDate.difference(DateTime.now());
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }
}

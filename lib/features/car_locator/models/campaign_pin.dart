class CampaignPin {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final String type;
  final int tokenRequired;
  final bool isExclusive;
  final DateTime expiryDate;

  CampaignPin({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
    this.tokenRequired = 0,
    this.isExclusive = false,
    required this.expiryDate,
  });
}

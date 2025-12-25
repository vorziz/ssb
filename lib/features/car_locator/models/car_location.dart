class CarLocation {
  final double latitude;
  final double longitude;
  final DateTime parkedAt;
  final String location;

  CarLocation({
    required this.latitude,
    required this.longitude,
    required this.parkedAt,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'parkedAt': parkedAt.toIso8601String(),
    'location': location,
  };

  factory CarLocation.fromJson(Map<String, dynamic> json) => CarLocation(
    latitude: json['latitude'],
    longitude: json['longitude'],
    parkedAt: DateTime.parse(json['parkedAt']),
    location: json['location'],
  );
}

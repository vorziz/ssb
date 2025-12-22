enum BookingStatus { pending, confirmed, completed }

class BookingModel {
  final String id;
  final String serviceId;
  final DateTime dateTime;
  final String location;
  final BookingStatus status;

  BookingModel({
    required this.id,
    required this.serviceId,
    required this.dateTime,
    required this.status,
    this.location = '',
  });

  BookingModel copyWith({
    String? id,
    String? serviceId,
    DateTime? dateTime,
    String? location,
    BookingStatus? status,
  }) {
    return BookingModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      status: status ?? this.status,
    );
  }
}

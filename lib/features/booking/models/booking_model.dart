enum BookingStatus {
  pending,
  confirmed,
  completed,
  failed,
}

class BookingModel {
  final String id;
  final String serviceId;
  final DateTime dateTime;
  final BookingStatus status;

  BookingModel({
    required this.id,
    required this.serviceId,
    required this.dateTime,
    required this.status,
  });

  BookingModel copyWith({
    BookingStatus? status,
  }) {
    return BookingModel(
      id: id,
      serviceId: serviceId,
      dateTime: dateTime,
      status: status ?? this.status,
    );
  }
}

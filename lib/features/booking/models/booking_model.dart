enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final ServiceModel service;
  BookingStatus status;
  DateTime bookingTime;

  BookingModel({
    required this.id,
    required this.service,
    required this.status,
    required this.bookingTime,
  });
}

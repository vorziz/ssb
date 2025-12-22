import 'dart:async';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var currentBooking = Rxn<BookingModel>();
  Timer? _timer;

  void createBooking(ServiceModel service) {
    currentBooking.value = BookingModel(
      id: DateTime.now().toString(),
      service: service,
      status: BookingStatus.pending,
      bookingTime: DateTime.now(),
    );

    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (currentBooking.value?.status == BookingStatus.pending) {
          currentBooking.value?.status = BookingStatus.confirmed;
          currentBooking.refresh();
          _timer?.cancel();
        }
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

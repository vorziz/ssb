import 'dart:async';
import 'package:get/get.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  final WalletController walletController;

  BookingController(this.walletController);

  var currentBooking = Rxn<BookingModel>();
  Timer? _pollingTimer;

  void createBooking({
    required String serviceId,
    required int price,
    required WalletType paymentType,
  }) {
    if (!walletController.hasEnoughBalance(
      amount: price,
      type: paymentType,
    )) {
      return;
    }

    walletController.deductBalance(
      amount: price,
      type: paymentType,
      description: 'Booking service $serviceId',
    );

    currentBooking.value = BookingModel(
      id: DateTime.now().toString(),
      serviceId: serviceId,
      dateTime: DateTime.now(),
      status: BookingStatus.pending,
    );

    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        _updateBookingStatus();
      },
    );
  }

  void _updateBookingStatus() {
    if (currentBooking.value == null) return;

    final status = currentBooking.value!.status;

    if (status == BookingStatus.pending) {
      currentBooking.value =
          currentBooking.value!.copyWith(status: BookingStatus.confirmed);
    } else if (status == BookingStatus.confirmed) {
      currentBooking.value =
          currentBooking.value!.copyWith(status: BookingStatus.completed);
      _pollingTimer?.cancel();
    }
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
  }
}

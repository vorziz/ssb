import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  final WalletController walletController;

  BookingController(this.walletController);

  var currentBooking = Rxn<BookingModel>();
  var bookingHistory = <BookingModel>[].obs;
  Timer? _pollingTimer;

  void resetBooking() {
    currentBooking.value = null;
    _pollingTimer?.cancel();
  }

  void createBooking({
    required String serviceId,
    required int price,
    required WalletType paymentType,
    required DateTime date,
    required TimeOfDay time,
    required String location,
  }) {
    // Validate balance before proceeding
    if (!walletController.hasEnoughBalance(
      amount: price,
      type: paymentType,
    )) {
      final balanceType = paymentType == WalletType.cash ? 'cash' : 'tokens';
      Get.snackbar(
        'Insufficient Balance',
        'You don\'t have enough $balanceType to complete this booking',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    walletController.deductBalance(
      amount: price,
      type: paymentType,
      description: 'Booking: $serviceId at $location',
    );

    final bookingDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    currentBooking.value = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      serviceId: serviceId,
      dateTime: bookingDateTime,
      location: location,
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
      bookingHistory.insert(0, currentBooking.value!);
      _pollingTimer?.cancel();
    }
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
  }
}

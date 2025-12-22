import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../booking/controllers/booking_controller.dart';
import '../../booking/models/booking_model.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../services/models/service_model.dart';

class BookingConfirmationPage extends StatefulWidget {
  final ServiceModel service;

  const BookingConfirmationPage({
    super.key,
    required this.service,
  });

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  WalletType selectedPayment = WalletType.cash;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedLocation = 'Main Branch';

  final List<String> locations = [
    'Main Branch',
    'City Center',
    'Airport Terminal',
    'Mall Parking',
  ];

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.find<BookingController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final booking = bookingController.currentBooking.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.service.name,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Price: RM ${widget.service.price}'),

              const SizedBox(height: 24),
              const Text('Select Date', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text('Select Time', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickTime,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedTime.format(context)),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text('Select Location', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: locations.map((loc) {
                  return DropdownMenuItem(value: loc, child: Text(loc));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedLocation = val);
                },
              ),

              const SizedBox(height: 24),
              const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile<WalletType>(
                title: const Text('Cash (RM)'),
                value: WalletType.cash,
                groupValue: selectedPayment,
                onChanged: (v) => setState(() => selectedPayment = v!),
              ),
              RadioListTile<WalletType>(
                title: const Text('Tokens'),
                value: WalletType.token,
                groupValue: selectedPayment,
                onChanged: (v) => setState(() => selectedPayment = v!),
              ),

              const SizedBox(height: 24),

              if (booking == null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final walletController = Get.find<WalletController>();
                      if (!walletController.hasEnoughBalance(
                        amount: widget.service.price,
                        type: selectedPayment,
                      )) {
                        Get.snackbar('Error', 'Insufficient balance');
                        return;
                      }

                      bookingController.createBooking(
                        serviceId: widget.service.id,
                        price: widget.service.price,
                        paymentType: selectedPayment,
                        date: selectedDate,
                        time: selectedTime,
                        location: selectedLocation,
                      );
                      Get.snackbar('Success', 'Booking created!');
                    },
                    child: const Text('Confirm Booking'),
                  ),
                ),

              if (booking != null) ...[
                const SizedBox(height: 24),
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Booking Status', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          booking.status.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: booking.status == BookingStatus.completed
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Location: ${booking.location}'),
                        Text('Date: ${booking.dateTime.day}/${booking.dateTime.month}/${booking.dateTime.year}'),
                      ],
                    ),
                  ),
                ),
                if (booking.status == BookingStatus.completed) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bookingController.resetBooking();
                      },
                      child: const Text('Book Again'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text('Back to Services'),
                    ),
                  ),
                ],
              ],
            ],
          );
        }),
      ),
    );
  }
}

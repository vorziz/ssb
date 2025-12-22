import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/service_controller.dart';
import 'package:ssb/features/booking/ui/booking_confirmation_page.dart';

class ServiceListPage extends GetView<ServiceController> {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerList();
      }

      if (controller.services.isEmpty) {
        return const Center(child: Text('No services available'));
      }

      return ListView.builder(
        itemCount: controller.services.length,
        itemBuilder: (_, index) {
          final service = controller.services[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: service.isAvailable ? Colors.green : Colors.grey,
                child: Icon(
                  _getServiceIcon(service.name),
                  color: Colors.white,
                ),
              ),
              title: Text(service.name),
              subtitle: Text('RM ${service.price}'),
              trailing: service.isAvailable
                  ? ElevatedButton(
                      onPressed: () {
                        Get.to(() => BookingConfirmationPage(service: service));
                      },
                      child: const Text('Book'),
                    )
                  : const Chip(
                      label: Text('Unavailable'),
                      backgroundColor: Colors.grey,
                    ),
            ),
          );
        },
      );
    });
  }

  IconData _getServiceIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('valet')) return Icons.directions_car;
    if (lower.contains('wash')) return Icons.local_car_wash;
    if (lower.contains('bay') || lower.contains('parking')) return Icons.local_parking;
    return Icons.miscellaneous_services;
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const CircleAvatar(),
              title: Container(
                height: 16,
                width: 100,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 12,
                width: 60,
                margin: const EdgeInsets.only(top: 4),
                color: Colors.white,
              ),
              trailing: Container(
                height: 36,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

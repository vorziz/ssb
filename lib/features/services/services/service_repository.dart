import 'dart:async';
import '../models/service_model.dart';

class ServiceRepository {
  Future<List<ServiceModel>> fetchServices() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ServiceModel(
        id: 'valet',
        name: 'Valet Parking',
        price: 20,
        isAvailable: true,
      ),
      ServiceModel(
        id: 'car_wash',
        name: 'Car Wash',
        price: 15,
        isAvailable: true,
      ),
      ServiceModel(
        id: 'bay',
        name: 'Bay Reservation',
        price: 10,
        isAvailable: false,
      ),
    ];
  }
}

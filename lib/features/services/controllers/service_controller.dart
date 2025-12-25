import 'package:get/get.dart';
import '../models/service_model.dart';

class ServiceController extends GetxController {
  var services = <ServiceModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading.value = true;
      
      // Simulate API call with optimized delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      services.value = [
        ServiceModel(id: '1', name: 'Valet Parking', price: 50, isAvailable: true),
        ServiceModel(id: '2', name: 'Premium Car Wash', price: 80, isAvailable: true),
        ServiceModel(id: '3', name: 'Bay Reservation', price: 30, isAvailable: true),
        ServiceModel(id: '4', name: 'Full Detailing', price: 200, isAvailable: false),
        ServiceModel(id: '5', name: 'Quick Wash', price: 25, isAvailable: true),
      ];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load services');
    } finally {
      isLoading.value = false;
    }
  }
}

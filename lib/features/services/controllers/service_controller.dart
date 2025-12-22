import 'package:get/get.dart';
import '../models/service_model.dart';
import '../services/service_repository.dart';

class ServiceController extends GetxController {
  final ServiceRepository repository;

  ServiceController(this.repository);

  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadServices();
  }

  Future<void> loadServices() async {
    isLoading.value = true;
    services.value = await repository.fetchServices();
    isLoading.value = false;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation/main_page.dart';
import 'features/services/controllers/service_controller.dart';
import 'features/wallet/controllers/wallet_controller.dart';
import 'features/rewards/controllers/reward_controller.dart';
import 'features/booking/controllers/booking_controller.dart';
import 'features/home/controllers/home_controller.dart'; 
import 'features/car_locator/controllers/car_locator_controller.dart';
import 'navigation/bottom_nav_controller.dart';
import 'core/utils/app_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final walletController = Get.put(WalletController());
  Get.put(BookingController(walletController));
  Get.put(ServiceController());
  Get.put(RewardController());
  Get.put(BottomNavController());
  Get.put(HomeController());
  Get.put(CarLocatorController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Service App',
      initialBinding: AppBinding(),
      home: MainPage(),
    );
  }
}

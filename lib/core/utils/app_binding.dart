import 'package:get/get.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/services/controllers/service_controller.dart';
import '../../features/wallet/controllers/wallet_controller.dart';
import '../../features/rewards/controllers/reward_controller.dart';
import '../../features/booking/controllers/booking_controller.dart';
import '../../navigation/bottom_nav_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final walletController = Get.put(WalletController());
    Get.put(BookingController(walletController));
    Get.put(ServiceController());
    Get.put(RewardController());
    Get.put(BottomNavController());
    Get.put(HomeController());
  }
}

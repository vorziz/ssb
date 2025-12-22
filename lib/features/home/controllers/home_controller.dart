import 'package:get/get.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../services/controllers/service_controller.dart';
import '../../rewards/controllers/reward_controller.dart';
import '../../booking/controllers/booking_controller.dart';

class HomeController extends GetxController {
  
  final WalletController walletController = Get.find();
  final ServiceController serviceController = Get.find();
  final RewardController rewardController = Get.find();
  final BookingController bookingController = Get.find();

  int get totalServicesAvailable => 
      serviceController.services.where((s) => s.isAvailable).length;
  
  int get totalRewardsClaimable => 
      rewardController.rewards.where((r) => !r.isClaimed).length;
  
  int get totalClaimedRewards => 
      rewardController.claimedRewards.length;
  
  int get totalBookings => 
      bookingController.bookingHistory.length;

  String walletSummary() {
    return 'RM ${walletController.cashBalance.value}';
  }
  
  String tokenSummary() {
    return '${walletController.tokenBalance.value} Tokens';
  }
  
  int get totalTransactions => 
      walletController.transactions.length;
}

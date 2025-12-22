import 'package:get/get.dart';
import '../models/reward_model.dart';

class RewardController extends GetxController {
  var rewards = <RewardModel>[].obs;
  var claimedRewards = <RewardModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    rewards.value = [
      RewardModel(
        id: 'r1',
        title: 'Free Valet Service',
        expiryDate: DateTime.now().add(const Duration(days: 3)),
      ),
      RewardModel(
        id: 'r2',
        title: '20% Car Wash Discount',
        expiryDate: DateTime.now().add(const Duration(hours: 2)),
      ),
      RewardModel(
        id: 'r3',
        title: 'Free Parking 1 Hour',
        expiryDate: DateTime.now().add(const Duration(days: 1)),
      ),
      RewardModel(
        id: 'r4',
        title: 'Buy 1 Get 1 Bay Reservation',
        expiryDate: DateTime.now().add(const Duration(hours: 5)),
      ),
    ];
  }

  void claimReward(String id) {
    final index = rewards.indexWhere((e) => e.id == id);
    if (index != -1) {
      rewards[index].isClaimed = true;
      rewards[index].claimedAt = DateTime.now();
      claimedRewards.add(rewards[index]);
      rewards.refresh();
      claimedRewards.refresh();
      Get.snackbar('Claimed!', 'Reward added to your wallet');
    }
  }

  void redeemReward(String id) {
    final index = claimedRewards.indexWhere((e) => e.id == id);
    if (index != -1) {
      claimedRewards.removeAt(index);
      Get.snackbar('Redeemed!', 'Reward has been used');
    }
  }
}
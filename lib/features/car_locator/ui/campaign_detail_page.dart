import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/campaign_pin.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../rewards/controllers/reward_controller.dart';
import '../../rewards/models/reward_model.dart';

class CampaignDetailPage extends StatelessWidget {
  final CampaignPin campaign;

  const CampaignDetailPage({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();
    final rewardController = Get.find<RewardController>();

    return Scaffold(
      appBar: AppBar(title: Text(campaign.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (campaign.isExclusive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'EXCLUSIVE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              campaign.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              campaign.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text('Expires: ${campaign.expiryDate.day}/${campaign.expiryDate.month}/${campaign.expiryDate.year}'),
              ],
            ),
            const SizedBox(height: 12),
            if (campaign.tokenRequired > 0)
              Row(
                children: [
                  const Icon(Icons.toll, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text('Requires ${campaign.tokenRequired} tokens'),
                ],
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (campaign.tokenRequired > 0) {
                    if (walletController.tokenBalance.value < campaign.tokenRequired) {
                      Get.snackbar('Error', 'Not enough tokens');
                      return;
                    }
                  }

                  final reward = RewardModel(
                    id: campaign.id,
                    title: campaign.title,
                    expiryDate: campaign.expiryDate,
                  );
                  
                  rewardController.claimedRewards.add(reward);
                  
                  if (campaign.tokenRequired > 0) {
                    walletController.deductBalance(
                      amount: campaign.tokenRequired,
                      type: WalletType.token,
                      description: 'Claimed: ${campaign.title}',
                    );
                  }
                  
                  Get.back();
                  Get.snackbar('Success', 'Campaign claimed!');
                },
                child: const Text('Claim Reward'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../services/controllers/service_controller.dart';
import '../../rewards/controllers/reward_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();
    final serviceController = Get.find<ServiceController>();
    final rewardController = Get.find<RewardController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Wallet Balance'),
              subtitle: Text('RM ${walletController.cashBalance.value} | ${walletController.tokenBalance.value} Tokens'),
            ),
          )),
          
          const SizedBox(height: 12),
          
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Services Available'),
              subtitle: Text('${serviceController.services.where((s) => s.isAvailable).length} services'),
            ),
          )),
          
          const SizedBox(height: 12),
          
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Rewards'),
              subtitle: Text('${rewardController.rewards.where((r) => !r.isClaimed).length} available'),
            ),
          )),
          
          const SizedBox(height: 12),
          
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Claimed Rewards'),
              subtitle: Text('${rewardController.claimedRewards.length} claimed'),
            ),
          )),
          
          const SizedBox(height: 24),
          
          Obx(() {
            if (walletController.transactions.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Recent Transactions'),
                  subtitle: Text('No transactions yet'),
                ),
              );
            }
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...walletController.transactions.take(3).map((tx) => Card(
                  child: ListTile(
                    title: Text(tx.description),
                    subtitle: Text('${tx.date.day}/${tx.date.month}/${tx.date.year}'),
                    trailing: Text('-${tx.amount} ${tx.type}'),
                  ),
                )),
              ],
            );
          }),
        ],
      ),
    );
  }
}

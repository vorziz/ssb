import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reward_controller.dart';
import '../models/reward_model.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    if (d.isNegative) return 'Expired';
    
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else {
      return '${minutes}m ${seconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RewardController>();

    return Obx(() {
      return ListView(
        children: [
          if (controller.claimedRewards.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Claimed Rewards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...controller.claimedRewards.map((reward) => _buildClaimedCard(reward, controller)),
            const Divider(),
          ],
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Available Rewards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...controller.rewards.where((r) => !r.isClaimed).map((reward) => _buildRewardCard(reward, controller)),
        ],
      );
    });
  }

  Widget _buildClaimedCard(RewardModel reward, RewardController controller) {
    final remaining = reward.timeRemaining;
    final isExpired = remaining.isNegative;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isExpired ? Colors.grey.shade200 : Colors.green.shade50,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isExpired ? Colors.grey : Colors.green,
          child: const Icon(Icons.card_giftcard, color: Colors.white),
        ),
        title: Text(reward.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isExpired ? 'Expired' : 'Expires in: ${formatDuration(remaining)}',
              style: TextStyle(
                color: isExpired ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: isExpired
            ? const Text('Expired', style: TextStyle(color: Colors.red))
            : ElevatedButton(
                onPressed: () => controller.redeemReward(reward.id),
                child: const Text('Use'),
              ),
      ),
    );
  }

  Widget _buildRewardCard(RewardModel reward, RewardController controller) {
    final remaining = reward.timeRemaining;
    final isExpired = remaining.isNegative;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(reward.title),
        subtitle: Text(
          'Expires in: ${formatDuration(remaining)}',
          style: TextStyle(
            color: remaining.inHours < 6 ? Colors.orange : Colors.grey,
          ),
        ),
        trailing: isExpired
            ? const Text('Expired', style: TextStyle(color: Colors.red))
            : ElevatedButton(
                onPressed: () => controller.claimReward(reward.id),
                child: const Text('Claim'),
              ),
      ),
    );
  }
}

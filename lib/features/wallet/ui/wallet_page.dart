import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import 'transaction_history_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Cash Balance'),
              trailing: Text(
                'RM ${walletController.cashBalance.value}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          
          const SizedBox(height: 12),
          
          Obx(() => Card(
            child: ListTile(
              leading: const Icon(Icons.toll),
              title: const Text('Token Balance'),
              trailing: Text(
                '${walletController.tokenBalance.value} Tokens',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (walletController.hasEnoughBalance(amount: 100, type: WalletType.cash)) {
                      walletController.deductBalance(
                        amount: 100,
                        type: WalletType.cash,
                        description: 'Payment',
                      );
                      Get.snackbar('Done', 'RM 100 paid');
                    } else {
                      Get.snackbar('Error', 'Not enough cash');
                    }
                  },
                  child: const Text('Pay RM 100'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (walletController.hasEnoughBalance(amount: 10, type: WalletType.token)) {
                      walletController.deductBalance(
                        amount: 10,
                        type: WalletType.token,
                        description: 'Token Payment',
                      );
                      Get.snackbar('Done', '10 tokens used');
                    } else {
                      Get.snackbar('Error', 'Not enough tokens');
                    }
                  },
                  child: const Text('Use 10 Tokens'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => const TransactionHistoryPage()),
              child: const Text('View Transaction History'),
            ),
          ),
        ],
      ),
    );
  }
}

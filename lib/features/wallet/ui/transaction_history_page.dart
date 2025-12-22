import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: Obx(() {
        if (walletController.transactions.isEmpty) {
          return const Center(
            child: Text('No transactions yet'),
          );
        }

        return ListView.builder(
          itemCount: walletController.transactions.length,
          itemBuilder: (context, index) {
            final tx = walletController.transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: tx.type == 'Cash' ? Colors.green : Colors.orange,
                  child: Icon(
                    tx.type == 'Cash' ? Icons.attach_money : Icons.toll,
                    color: Colors.white,
                  ),
                ),
                title: Text(tx.description),
                subtitle: Text(
                  '${tx.date.day}/${tx.date.month}/${tx.date.year} ${tx.date.hour}:${tx.date.minute.toString().padLeft(2, '0')}',
                ),
                trailing: Text(
                  '-${tx.amount} ${tx.type == 'Cash' ? 'RM' : 'Tokens'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

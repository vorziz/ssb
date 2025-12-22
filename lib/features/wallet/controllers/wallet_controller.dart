import 'package:get/get.dart';
import '../models/wallet_transaction.dart';

enum WalletType { wallet, token }

class WalletController extends GetxController {
  var walletBalance = 120.obs; // RM
  var tokenBalance = 50.obs;   // GP Coins

  var transactions = <WalletTransaction>[].obs;

  bool hasEnoughBalance({
    required int amount,
    required WalletType type,
  }) {
    if (type == WalletType.token) {
      return tokenBalance.value >= amount;
    }
    return walletBalance.value >= amount;
  }

  void deductBalance({
    required int amount,
    required WalletType type,
    required String description,
  }) {
    if (!hasEnoughBalance(amount: amount, type: type)) {
      return;
    }

    if (type == WalletType.token) {
      tokenBalance.value -= amount;
    } else {
      walletBalance.value -= amount;
    }

    transactions.insert(
      0,
      WalletTransaction(
        id: DateTime.now().toString(),
        type: WalletTransactionType.debit,
        amount: amount,
        date: DateTime.now(),
        description: description,
      ),
    );
  }
}

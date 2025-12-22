import 'package:get/get.dart';
import '../models/transaction_model.dart';

enum WalletType { cash, token }

class WalletController extends GetxController {
  var cashBalance = 500000.obs;
  var tokenBalance = 50.obs;
  var transactions = <TransactionModel>[].obs;

  bool hasEnoughBalance({
    required int amount,
    required WalletType type,
  }) {
    if (type == WalletType.cash) {
      return cashBalance.value >= amount;
    } else {
      return tokenBalance.value >= amount;
    }
  }

  void deductBalance({
    required int amount,
    required WalletType type,
    required String description,
  }) {
    if (type == WalletType.cash) {
      cashBalance.value -= amount;
    } else {
      tokenBalance.value -= amount;
    }

    transactions.insert(0, TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      description: description,
      amount: amount,
      type: type == WalletType.cash ? 'Cash' : 'Token',
      date: DateTime.now(),
    ));
  }

  void topUp({required int amount, required WalletType type}) {
    if (type == WalletType.cash) {
      cashBalance.value += amount;
    } else {
      tokenBalance.value += amount;
    }

    transactions.insert(0, TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      description: 'Top Up',
      amount: amount,
      type: type == WalletType.cash ? 'Cash' : 'Token',
      date: DateTime.now(),
    ));
  }
}

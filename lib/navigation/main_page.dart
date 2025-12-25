import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/services/ui/service_list_page.dart';
import '../features/wallet/ui/wallet_page.dart';
import '../features/rewards/ui/rewards_page.dart';
import '../features/home/ui/home_page.dart';
import '../features/car_locator/ui/map_view_page.dart';

import 'bottom_nav_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final BottomNavController navController = Get.find();

  final List<String> titles = [
    'Home',
    'Services',
    'Wallet',
    'Rewards',
    'Discover',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(titles[navController.currentIndex.value]),
        ),
        body: IndexedStack(
          index: navController.currentIndex.value,
          children: [
            HomePage(),
            ServiceListPage(),
            WalletPage(),
            RewardsPage(),
            MapViewPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeTab,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Discover',
            ),
          ],
        ),
      ),
    );
  }
}

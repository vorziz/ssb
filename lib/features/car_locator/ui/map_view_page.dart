import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/car_locator_controller.dart';
import 'campaign_detail_page.dart';
import 'grocery_list_page.dart';
import 'qr_scanner_page.dart';

class MapViewPage extends StatelessWidget {
  const MapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarLocatorController>();
    final mapController = MapController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Retail Discovery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => const GroceryListPage()),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Get.to(() => const QRScannerPage()),
          ),
          Obx(() => IconButton(
            icon: Icon(
              controller.showExclusiveOnly.value 
                ? Icons.filter_alt 
                : Icons.filter_alt_outlined
            ),
            onPressed: controller.toggleExclusiveFilter,
            tooltip: 'Exclusive Only',
          )),
        ],
      ),
      body: Obx(() => FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: const LatLng(3.1390, 101.6869),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.ssb',
          ),
          MarkerLayer(
            markers: [
              if (controller.carLocation.value != null)
                Marker(
                  point: LatLng(
                    controller.carLocation.value!.latitude,
                    controller.carLocation.value!.longitude,
                  ),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              ...controller.filteredCampaigns.map((campaign) => Marker(
                point: LatLng(campaign.latitude, campaign.longitude),
                width: 80,
                height: 80,
                child: GestureDetector(
                  onTap: () => Get.to(() => CampaignDetailPage(campaign: campaign)),
                  child: Column(
                    children: [
                      Icon(
                        campaign.isExclusive ? Icons.star : Icons.location_on,
                        color: campaign.isExclusive ? Colors.amber : Colors.red,
                        size: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          campaign.type,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ],
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'park',
            onPressed: () {
              controller.parkCar(3.1390, 101.6869, 'Parking Lot A');
            },
            child: const Icon(Icons.local_parking),
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.carLocation.value != null) {
              return FloatingActionButton(
                heroTag: 'navigate',
                onPressed: () => Get.to(() => const ARNavigationPage()),
                child: const Icon(Icons.navigation),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class ARNavigationPage extends StatelessWidget {
  const ARNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarLocatorController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Find My Car')),
      body: Obx(() {
        if (controller.carLocation.value == null) {
          return const Center(child: Text('No car location saved'));
        }

        final direction = controller.getDirectionToCar(3.1390, 101.6869);
        
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.explore, size: 100, color: Colors.blue),
              const SizedBox(height: 24),
              Text(
                'Direction: $direction',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Parked at: ${controller.carLocation.value!.location}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Time: ${controller.carLocation.value!.parkedAt.hour}:${controller.carLocation.value!.parkedAt.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => controller.clearCarLocation(),
                icon: const Icon(Icons.delete),
                label: const Text('Clear Location'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

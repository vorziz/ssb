import 'package:get/get.dart';
import '../models/car_location.dart';
import '../models/campaign_pin.dart';

class CarLocatorController extends GetxController {
  var carLocation = Rxn<CarLocation>();
  var campaigns = <CampaignPin>[].obs;
  var showExclusiveOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCampaigns();
  }

  void parkCar(double lat, double lng, String location) {
    carLocation.value = CarLocation(
      latitude: lat,
      longitude: lng,
      parkedAt: DateTime.now(),
      location: location,
    );
    Get.snackbar('Success', 'Car location saved');
  }

  void clearCarLocation() {
    carLocation.value = null;
    Get.snackbar('Cleared', 'Car location removed');
  }

  void _loadCampaigns() {
    campaigns.value = [
      CampaignPin(
        id: 'c1',
        title: 'Flash Sale - 50% Off',
        description: 'Limited time offer on all car wash services',
        latitude: 3.1390,
        longitude: 101.6869,
        type: 'Sale',
        expiryDate: DateTime.now().add(const Duration(hours: 2)),
      ),
      CampaignPin(
        id: 'c2',
        title: 'VIP Lounge Access',
        description: 'Exclusive for token holders',
        latitude: 3.1395,
        longitude: 101.6875,
        type: 'Exclusive',
        tokenRequired: 10,
        isExclusive: true,
        expiryDate: DateTime.now().add(const Duration(days: 7)),
      ),
      CampaignPin(
        id: 'c3',
        title: 'Free Coffee',
        description: 'Complimentary coffee at our cafe',
        latitude: 3.1385,
        longitude: 101.6865,
        type: 'Event',
        expiryDate: DateTime.now().add(const Duration(days: 1)),
      ),
      CampaignPin(
        id: 'c4',
        title: 'Premium Detailing',
        description: 'Token holders get 30% discount',
        latitude: 3.1400,
        longitude: 101.6880,
        type: 'Exclusive',
        tokenRequired: 5,
        isExclusive: true,
        expiryDate: DateTime.now().add(const Duration(days: 3)),
      ),
    ];
  }

  List<CampaignPin> get filteredCampaigns {
    if (showExclusiveOnly.value) {
      return campaigns.where((c) => c.isExclusive).toList();
    }
    return campaigns;
  }

  void toggleExclusiveFilter() {
    showExclusiveOnly.value = !showExclusiveOnly.value;
  }

  double getDistanceToCar(double currentLat, double currentLng) {
    if (carLocation.value == null) return 0;
    
    final lat1 = currentLat;
    final lon1 = currentLng;
    final lat2 = carLocation.value!.latitude;
    final lon2 = carLocation.value!.longitude;

    final dLat = (lat2 - lat1) * 111000;
    final dLon = (lon2 - lon1) * 111000;
    
    return (dLat * dLat + dLon * dLon).abs();
  }

  String getDirectionToCar(double currentLat, double currentLng) {
    if (carLocation.value == null) return 'N/A';
    
    final dLat = carLocation.value!.latitude - currentLat;
    final dLon = carLocation.value!.longitude - currentLng;
    
    if (dLat.abs() > dLon.abs()) {
      return dLat > 0 ? 'North' : 'South';
    } else {
      return dLon > 0 ? 'East' : 'West';
    }
  }
}

# Smart Service Booking

Flutter application for service booking with wallet system and rewards.

## Overview

This project implements a service booking system with dual wallet (cash and tokens), rewards center, and car locator features.

**Implemented:**
- Task 1: Service Booking + Wallet & Loyalty System
- Task 2: AR Car Locator + Retail Explorer (Bonus)

## Features

### Service Booking
- Service listing with availability and pricing
- Date/time/location selection
- Live status updates (pending → confirmed → completed)
- Shimmer loading effects

### Wallet System
- Dual balance: Cash (RM) and Tokens
- Transaction history
- Top-up functionality
- Payment selection for bookings

### Rewards Center
- Available and claimed rewards tabs
- Countdown timers on offers
- Claim and redeem functionality

### Car Locator
- Save parking location
- Compass direction (N/S/E/W)
- Distance calculation
- OpenStreetMap integration

### Retail Discovery
- Campaign pins on map
- Exclusive offers filter
- Tap to view details
- Claim rewards from map

### Bonus Features
- Grocery list with "Send to Valet"
- Real QR scanner (mobile_scanner package)
- Push notification simulation

## Technical Stack

**Flutter:** 3.35.2  
**Dart:** 3.9.0  
**State Management:** GetX

### Dependencies
```yaml
get: ^4.7.3
shimmer: ^3.0.0
flutter_map: ^8.2.2
latlong2: ^0.9.1
mobile_scanner: ^7.1.4
permission_handler: ^12.0.1
```

## Setup

1. Clone repository
```bash
git clone https://github.com/vorziz/ssb.git
cd ssb
```

2. Install dependencies
```bash
flutter pub get
```

3. Run app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   └── utils/
├── features/
│   ├── booking/
│   ├── car_locator/
│   ├── home/
│   ├── rewards/
│   ├── services/
│   └── wallet/
├── navigation/
└── main.dart
```

## Architecture

Feature-based modular architecture with GetX for state management.

**Controllers:**
- WalletController - Balance and transactions
- ServiceController - Service listing
- BookingController - Booking management with polling
- RewardController - Rewards and claims
- CarLocatorController - Location and campaigns

## Implementation Notes

### Live Polling
```dart
void _startPolling() {
  _pollingTimer = Timer.periodic(
    const Duration(seconds: 2),
    (timer) => _updateBookingStatus(),
  );
}
```

### Countdown Timer
```dart
String _getRemainingTime(DateTime expiryDate) {
  final now = DateTime.now();
  final diff = expiryDate.difference(now);
  
  if (diff.inDays > 0) return '${diff.inDays}d ${diff.inHours % 24}h';
  if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}m';
  return 'Expired';
}
```

### QR Scanner
```dart
void onDetect(BarcodeCapture capture) {
  if (isScanned) return;
  
  final barcodes = capture.barcodes;
  for (final barcode in barcodes) {
    if (barcode.rawValue != null) {
      setState(() => isScanned = true);
      Get.snackbar('Success', 'Campaign validated!');
      break;
    }
  }
}
```

## Future Improvements

- Backend API integration
- Persistent storage (SQLite/Hive)
- User authentication
- Unit and integration tests
- Real AR implementation
- FCM push notifications

## Documentation

See [COMPLIANCE_CHECK.md](COMPLIANCE_CHECK.md) for detailed feature compliance and [feedback.md](feedback.md) for development notes.

## License

MIT License

## Author

Vorziz - [GitHub](https://github.com/vorziz)

# Smart Service Booking App

A Flutter application for service booking with wallet and loyalty system.

## Setup Instructions

### Requirements
- Flutter 3.35.2 or higher
- Dart 3.9.0 or higher

### Installation

1. Clone the repository
```bash
git clone https://github.com/vorziz/ssb.git
cd ssb
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## App Structure

```
lib/
├── core/
│   └── utils/
│       └── app_binding.dart
├── features/
│   ├── booking/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── ui/
│   ├── home/
│   │   ├── controllers/
│   │   └── ui/
│   ├── rewards/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── ui/
│   ├── services/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── services/
│   │   └── ui/
│   └── wallet/
│       ├── controllers/
│       ├── models/
│       └── ui/
├── navigation/
│   ├── bottom_nav_controller.dart
│   └── main_page.dart
└── main.dart
```

## State Management

This app uses **GetX** for state management. Each feature has its own controller that manages the state and business logic.

- `WalletController` - Manages cash and token balances, transactions
- `ServiceController` - Handles service listing and availability
- `BookingController` - Manages booking creation and status updates
- `RewardController` - Handles reward claiming and redemption
- `BottomNavController` - Controls bottom navigation state

## Features

### 1. Service Booking
- List of services with availability and prices
- Booking confirmation with date, time, and location selector
- Live booking status update using polling (pending → confirmed → completed)

### 2. Wallet System
- Dual balance: Cash (RM) and Tokens
- Transaction history with date, type, and amount
- Deduct from either Cash or Token for bookings

### 3. Rewards Center
- Offer listing with expiry dates
- Claim button to store rewards
- Countdown timer on claimed rewards
- Redeem functionality

### 4. UX Features
- Bottom navigation bar (Home, Services, Wallet, Rewards)
- Shimmer loading effect for services
- Snackbar notifications
- Real-time data updates on home screen

## Dependencies

- get: ^4.6.6 - State management
- shimmer: ^3.0.0 - Loading effects

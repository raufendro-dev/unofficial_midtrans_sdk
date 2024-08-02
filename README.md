# unofficial_midtrans_sdk

Welcome to `unofficial_midtrans_sdk`, a Flutter package that simplifies integration with the Midtrans payment gateway for both Android and iOS. This package is designed for developers who want to seamlessly integrate Midtrans payment functionalities into their Flutter apps without the hassle of dealing with complex configurations.

## Features

- **Easy Payment Integration**: Simplify the payment process with a straightforward API to initiate payments.
- **Transaction Status Tracking**: Effortlessly track the status of transactions to manage user experience and order processing.
- **Support for Production and Sandbox Environments**: Easily switch between production and sandbox modes for testing and live transactions.

## Installation

To use `unofficial_midtrans_sdk` in your Flutter project, follow these steps:

1. **Add the dependency**:
   
   Open your `pubspec.yaml` file and add `unofficial_midtrans_sdk` under dependencies:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     unofficial_midtrans_sdk: ^1.0.0  # Replace with the latest version

    ```

2. **Install the package**:

    Run `flutter pub get` to install the new dependency.

## How to use

First, initialize the midtransSDK class with your API key and environment setting:

```dart
import 'package:unofficial_midtrans_sdk/unofficial_midtrans_sdk.dart';

final midtrans = midtransSDK(
  apikey: 'YOUR_API_KEY', // Replace with your Midtrans API key
  isProduction: false,    // Set to true for production environment
);
```


Use the pay method to initiate a payment:

```dart
void makePayment() async {
  final response = await midtrans.pay({
    'transaction_details': {
      'order_id': 'ORDER_ID', // Replace with your order ID
      'gross_amount': 10000, // Replace with the total amount
    },
    // Additional payment parameters here
  });

  if (response['redirect_url'] != null) {
    // Navigate to the payment URL or open in a WebView
    final redirectUrl = response['redirect_url'];
    print('Redirect to: $redirectUrl');
  } else {
    // Do what you want here
  }
}
```

To check the status of a transaction, use the status method:

```dart
void checkTransactionStatus(String orderId) async {
  final statusResponse = await midtrans.status(orderId);

  if (statusResponse['status_code'] == "404") {
    print('Payment has not been completed.');
  } else {
    print('Transaction Status: ${statusResponse['transaction_status']}');
    print('Response: $statusResponse');
  }
}
```

## Example

Here is an example of how to use the package within a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:unofficial_midtrans_sdk/unofficial_midtrans_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final midtrans = midtransSDK(
    apikey: 'YOUR_API_KEY',
    isProduction: false,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Midtrans Payment Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Make payment
              makePayment(midtrans);
            },
            child: Text('Make Payment'),
          ),
        ),
      ),
    );
  }

  void makePayment(midtransSDK midtrans) async {
    final response = await midtrans.pay({
      'transaction_details': {
        'order_id': 'ORDER_ID',
        'gross_amount': 10000,
      },
    });

    if (response['redirect_url'] != null) {
      final redirectUrl = response['redirect_url'];
      print('Redirect to: $redirectUrl');
      // Navigate to WebView with redirectUrl
    } else {
        // Write here
    }
  }
}

```

library unofficial_midtrans_sdk;

import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransSDK {
  late String apikey;
  late bool isProduction;

  MidtransSDK({required this.apikey, required this.isProduction});

  late var apiUrl = isProduction
      ? 'https://app.midtrans.com/snap/v1/transactions'
      : 'https://app.sandbox.midtrans.com/snap/v1/transactions';

  Future<Map<dynamic, dynamic>> pay(Map<String, dynamic> body) async {
    String requestBody = jsonEncode(body);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ${base64Encode(utf8.encode('$apikey:'))}'
    };

    var response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: requestBody);

    return jsonDecode(response.body);
  }

  Future<Map<dynamic, dynamic>> status(String orderId) async {
    String url = 'https://api.sandbox.midtrans.com/v2/$orderId/status';

    String authToken = apikey;

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Basic ${base64Encode(utf8.encode('$apikey:'))}'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (jsonDecode(response.body)['status_code'] == "404") {
      Map<String, dynamic> belumBayar = {
        'status_code': 404,
        'transaction_status': 'Payment has not been completed'
      };
      return belumBayar;
    } else {
      return jsonDecode(response.body);
    }
  }
}

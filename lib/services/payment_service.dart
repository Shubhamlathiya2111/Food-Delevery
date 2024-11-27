import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentService {
  static const String merchantId = "mockMerchant123";
  static const String saltKey = "mockSaltKey123";
  static const String saltIndex = "1";
  static const String appId = "mockAppID123";

  static Future<void> initPhonePe() async {
    try {
      await PhonePePaymentSdk.init(
        'UAT', // Use 'PRODUCTION' for live environment
        appId,
        merchantId,
        true, // enableLogging
      );
    } catch (e) {
      print("PhonePe initialization error: $e");
    }
  }

  static String generateChecksum(String base64Body, String apiEndPoint) {
    final String input = base64Body + apiEndPoint + saltKey;
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return "$digest###$saltIndex";
  }

  static Future<Map<dynamic, dynamic>?> startPayment({
    required String amount,
    required String transactionId,
    required String callbackUrl,
  }) async {
    final Map<String, dynamic> payloadData = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "MUID123",
      "amount": int.parse(amount) * 100,
      "callbackUrl": callbackUrl,
      "mobileNumber": "9999999999",
      "paymentInstrument": {
        "type": "UPI_INTENT",
        "targetApp": "com.phonepe.app"
      }
    };

    final base64Body = base64.encode(utf8.encode(json.encode(payloadData)));
    final apiEndPoint = "/pg/v1/pay";
    final checksum = generateChecksum(base64Body, apiEndPoint);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-VERIFY': checksum,
    };

    try {
      return await PhonePePaymentSdk.startPGTransaction(
        base64Body,
        callbackUrl,
        checksum,
        headers,
        apiEndPoint,
        "com.phonepe.app",
      );
    } catch (e) {
      print("Payment error: $e");
      return null;
    }
  }
} 
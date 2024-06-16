import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/app/data/constants/constants.dart';
import 'package:login/app/views/login/otp_screen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final storedText = ''.obs; // Use RxString for reactive storedText
  String completePhoneNumber = '';

  Future<void> sendOTP(String type, String contact) async {
    String url = AppStrings.sendOtpUrl;
    Map<String, String> body = {"type": type, "contact": contact};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print('Response: ${data["message"]}');
        Get.to(OtpScreen(), arguments: {'type': type, 'contact': contact});
      } else {
        print('Failed to send OTP. Error: ${response.body}');
      }
    } catch (error) {
      print('Failed to connect to the server. Error: $error');
    }
  }

  void saveText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('storedText', text);
    storedText.value = text;
  }
}

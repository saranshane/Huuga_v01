import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:login/app/data/constants/constants.dart';
import 'package:login/app/views/registration/registration_screen.dart';

class OtpVerificationController extends GetxController {
  late String type;
  late String contact;
  late RxInt timerSeconds;

  Timer? _timer;

  List<TextEditingController> controllers = List.generate(
    AppConstants.otpDigits,
    (index) => TextEditingController(),
  );

  List<FocusNode> focusNodes = List.generate(
    AppConstants.otpDigits,
    (index) => FocusNode(),
  );

  @override
  void onInit() {
    timerSeconds = AppConstants.otpResendInterval.inSeconds.obs;
    type = '';
    contact = '';
    super.onInit();
  }

  void init(String type, String contact) {
    this.type = type;
    this.contact = contact;
    startTimer();
  }

  void startTimer() {
    timerSeconds.value = AppConstants.otpResendInterval.inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resendOTP() {
    startTimer();
  }

  Future<void> verifyOTP(String otp, String type, String contact) async {
    try {
      String url = AppStrings.otpVerifyUrl;
      Map<String, String> body = {
        'type': type,
        'contact': contact,
        'otp': otp,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("OTP verified successfully");
        Map<String, dynamic> data = jsonDecode(response.body);
        String userId = data["user"]["_id"];
        print(userId);
        Get.to(RegistrationScreen(), arguments: {'userId': userId});

        timerSeconds.value = 0;
      } else {
        print('Error verifying OTP: ${response.body}');
      }
    } catch (error) {
      print('Error verifying OTP: $error');
    }
  }
}

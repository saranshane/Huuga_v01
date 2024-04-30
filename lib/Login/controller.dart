import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class OtpController extends GetxController {
  var timerSeconds = 60.obs;
  var controllers = List<TextEditingController>.generate(4, (index) => TextEditingController()).obs;
  var focusNodes = List<FocusNode>.generate(4, (index) => FocusNode()).obs;
  var timer = Timer(Duration.zero, () {});

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerSeconds.value == 0) {
          timer.cancel();
        } else {
          timerSeconds.value--;
        }
      },
    );
  }

  @override
  void onClose() {
    timer.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
class ProfileController extends GetxController {
  final selectedGender = RxString('');

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }
}

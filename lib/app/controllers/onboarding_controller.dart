import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void onPageChanged(int value) {
    currentPage.value = value;
  }
}


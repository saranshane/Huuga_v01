import 'package:get/get.dart';
import 'package:login/app/views/home/home_screen.dart';

class DisclaimerController extends GetxController {
  void navigateToHomeScreen() {
    Get.offAll(() => HomeScreen());
  }
}

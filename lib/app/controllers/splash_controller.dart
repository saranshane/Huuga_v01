import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/home/home_screen.dart';
import '../views/onboarding/onboarding_screen.dart';
import 'package:login/app/data/constants/constants.dart';

class SplashController extends GetxController {
  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 10));
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPref.getBool(AppKeys.keyLogin) ?? false;

    isLoggedIn
        ? Get.offAll(() => HomeScreen())
        : Get.offAll(() => OnboardingScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:login/home/home_screen.dart';
import 'package:login/on_boarding/onboarding_screen.dart';
import 'package:login/constants.dart'; // Import the constants file

class EntryController extends GetxController {
  Future<void> checkLoginStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPref.getBool(AppKeys.keyLogin) ?? false;

    isLoggedIn
        ? Get.offAll(() => HomeScreen())
        : Get.offAll(() => OnboardingScreen());
  }
}

class EntryScreen extends StatelessWidget {
  final EntryController entryController = Get.put(EntryController());

  @override
  Widget build(BuildContext context) {
    entryController.checkLoginStatus();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStart,
                AppColors.gradientMiddle,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(child: Container()),
              Center(
                child: Container(
                  height: 400.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child:
                        Lottie.asset("assets/images/Entryscreen_Lottie.json"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Hüuga",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                "CONNECT | FEEL | HEAL",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Expanded(child: Container()),
              SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.gradientMiddle,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.gradientStart),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

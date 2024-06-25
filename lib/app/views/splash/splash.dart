import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:login/app/controllers/splash_controller.dart';
import 'package:login/app/data/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    splashController.checkLoginStatus();

    return Scaffold(
      body:Container(
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
    
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login/home/home_screen.dart';
// import 'package:login/on_boarding/onboarding_screen.dart';

// // Controller for entry screen logic
// class EntryController extends GetxController {
//   // Function to check login status and navigate accordingly
//   Future<void> checkLoginStatus() async {
//     final sharedPref = await SharedPreferences.getInstance();
//     final isLoggedIn = sharedPref.getBool(EntryScreen.keyLogin) ??
//         false; // Get login status from SharedPreferences

//     // Navigate to HomeScreen if logged in, otherwise navigate to OnboardingScreen
//     isLoggedIn
//         ? Get.offAll(() => HomeScreen()) // Navigate to HomeScreen
//         : Get.offAll(() => OnboardingScreen()); // Navigate to OnboardingScreen
//   }
// }

// class EntryScreen extends StatelessWidget {
//   final EntryController entryController =
//       Get.put(EntryController()); // Instance of EntryController

//   static const String keyLogin =
//       "Login"; // Key for login status in SharedPreferences

//   @override
//   Widget build(BuildContext context) {
//     entryController.checkLoginStatus(); // Check login status on screen build

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF9431A5),
//                 Color(0xFFAC303B),
//                 Color(0xFFF3BB1C),
//               ],
//             ),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                   child: Container()), // Expanded container for top spacing
//               Center(
//                 child: Container(
//                   height: 400.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Lottie.asset(
//                         "assets/images/Entryscreen_Lottie.json"), // Lottie animation
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20), // SizedBox for spacing
//               Text(
//                 "Hüuga", // App name
//                 style: TextStyle(fontSize: 40, color: Colors.black),
//               ),
//               SizedBox(height: 5), // SizedBox for spacing
//               Text(
//                 "CONNECT | FEEL | HEAL", // App slogan
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               Expanded(
//                   child: Container()), // Expanded container for bottom spacing
//               SizedBox(
//                 height: 10,
//                 child: LinearProgressIndicator(
//                   backgroundColor: Color(0xFFAC303B),
//                   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9431A5)),
//                 ),
//               ), // Linear progress indicator
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// lib/on_boarding/entry_screen.dart
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
                AppColors.gradientEnd,
                Color(0xFFF3BB1C),
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
                  backgroundColor: AppColors.gradientEnd,
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

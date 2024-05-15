import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Homescreen/Home_Screen.dart';
import 'package:login/Login/Otp_Screen.dart';
import 'package:login/OnBoarding/Entry_Screen.dart';
import 'package:login/OnBoarding/Onboarding_Screen.dart';
import 'package:login/Login/Login_Screen.dart';
import 'package:login/Registration/Registration.dart';
import 'package:login/ProfileScreen/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/EntryScreen', // Set initial route to onboarding screen
      getPages: [
        GetPage(
            name: '/EntryScreen', page: () => EntryScreen()), // Entry Screen
        GetPage(
            name: '/onboarding',
            page: () => OnboardingScreen()), // Onboarding Screen
        GetPage(name: '/login', page: () => LoginScreen()), // Login Screen
        GetPage(name: '/otp', page: () => OtpScreen()), // OTP Screen
        GetPage(
            name: '/Registration',
            page: () => Registration()), // Registration Screen
        GetPage(name: '/HomeScreen', page: () => Homescreen()), // Home Screen
        GetPage(
            name: '/profilescreen',
            page: () => ProfileScreen()) // Profile Screen
      ],
    );
  }
}

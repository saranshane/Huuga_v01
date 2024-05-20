import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Home/home_screen.dart';
import 'package:login/Login/otp_screen.dart';
import 'package:login/OnBoarding/entry_screen.dart';
import 'package:login/OnBoarding/onboarding_screen.dart';
import 'package:login/Login/login_screen.dart';
import 'package:login/Registration/registration_screen.dart';
import 'package:login/Profile/profile_screen.dart';

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
        GetPage(name: '/HomeScreen', page: () => HomeScreen()), // Home Screen
        GetPage(
            name: '/profilescreen',
            page: () => ProfileScreen()) // Profile Screen
      ],
    );
  }
}

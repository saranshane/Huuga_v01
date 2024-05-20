import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Home/HomeScreen.dart';
import 'package:login/Login/OtpScreen.dart';
import 'package:login/OnBoarding/EntryScreen.dart';
import 'package:login/OnBoarding/OnboardingScreen.dart';
import 'package:login/Login/LoginScreen.dart';
import 'package:login/Registration/Registration.dart';
import 'package:login/Profile/ProfileScreen.dart';

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

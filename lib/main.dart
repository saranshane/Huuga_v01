import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/home/home_screen.dart';
import 'package:login/login/otp_screen.dart';
import 'package:login/on_boarding/entry_screen.dart';
import 'package:login/on_boarding/onboarding_screen.dart';
import 'package:login/login/login_screen.dart';
import 'package:login/registration/registration_screen.dart';
import 'package:login/profile/profile_screen.dart';

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
            page: () => RegistrationScreen()), // Registration Screen
        GetPage(name: '/HomeScreen', page: () => HomeScreen()), // Home Screen
        GetPage(
            name: '/profilescreen',
            page: () => ProfileScreen()) // Profile Screen
      ],
    );
  }
}

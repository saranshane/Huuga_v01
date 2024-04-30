import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Homescreen/Homescreen.dart';
import 'package:login/Login/otp_screen.dart';
import 'package:login/onboarding/Entry_Screen.dart';
import 'package:login/onboarding/onboarding_screen.dart';
import 'package:login/Login/Login.dart';
import 'package:login/Registration/Registration.dart';
import 'package:login/ProfileScreen/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        GetPage(name: '/EntryScreen', page: () => EntryScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/otp', page: () => OtpScreen()),
        GetPage(name: '/Registration', page: () => Registration()),
        GetPage(name: '/HomeScreen', page: () => Homescreen()),
        GetPage(name: '/profilescreen', page: () => ProfileScreen())
      ],
    );
  }
}

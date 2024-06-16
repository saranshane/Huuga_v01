import 'package:get/get.dart';
import 'package:login/app/views/splash/splash.dart';
import 'package:login/app/views/home/home_screen.dart';
import 'package:login/app/views/login/otp_screen.dart';
import 'package:login/app/views/onboarding/onboarding_screen.dart';
import 'package:login/app/views/login/login_screen.dart';
import 'package:login/app/views/registration/registration_screen.dart';
import 'package:login/app/views/profile/profile_screen.dart';
import 'package:login/app/views/settings/settings_screen.dart';
import 'package:login/messages/message_screen.dart';

final List<GetPage> appPages = [
  GetPage(name: '/', page: () => SplashScreen()), // Entry Screen
  GetPage(
      name: '/onboarding', page: () => OnboardingScreen()), // Onboarding Screen
  GetPage(name: '/login', page: () => LoginScreen()), // Login Screen
  GetPage(name: '/otp', page: () => OtpScreen()), // OTP Screen
  GetPage(
      name: '/Registration',
      page: () => RegistrationScreen()), // Registration Screen
  GetPage(name: '/HomeScreen', page: () => HomeScreen()), // Home Screen
  GetPage(
      name: '/ProfileScreen', page: () => ProfileScreen()), // Profile Screen
  GetPage(
      name: '/settingsscreen', page: () => SettingsScreen()), //Settings Screen
  // GetPage(
  //   name: '/messagesscreen', page: () => MessagesScreen())
];

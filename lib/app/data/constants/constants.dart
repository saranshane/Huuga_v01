import 'package:flutter/material.dart';

// Colors
const kPrimaryColor = Color(0xFF9431A5);
const kSecondaryColor = Color(0xFFAC303B);
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

// Padding
const kDefaultPadding = 20.0;

// Strings
class AppStrings {
  static const String appName = "Hüuga";
  static const String appSlogan = "CONNECT | FEEL | HEAL";
  static const String lottieAsset = "assets/images/Entryscreen_Lottie.json";
  static const String keyLogin = "Login";
  static const String stayAnonymousTitle = "Stay Anonymous";
  static const String stayAnonymousText = "Let's Connect and Help Each Other";
  static const String expressFeelingsTitle = "Express Your Feeling to Someone";
  static const String expressFeelingsText =
      "Express yourself freely without any judgement\nor fear. Let Your imagination run wild!";

  static const String choosePersonTitle = "Choose your Perfect Person";
  static const String choosePersonText =
      "Easily find your type of person craving and\nyou’ll get delivery in wide range.";

  static const String next = "Next";
  static const String completeProfile = "Complete Profile";
  static const String fillDetails = "Please fill up the details";
  static const String nickname = "Nickname";
  static const String enterNickname = "Enter Your Nickname";
  static const String gender = "Gender";
  static const String aboutMe = "About Me";
  static const String enterText = "Enter The Text";
  static const String continueButton = "Continue";
  static const String male = "Male";
  static const String female = "Female";
  static const String other = "Other";
  static const String appBarImage = 'assets/images/Fill_up_Profile.jpeg';

  static const String welcomeBack = "Welcome Back";
  static const String loginToContinue = "Login to continue";
  static const String email = "Email";
  static const String mobileNumber = "Mobile Number";
  static const String or = "OR";
  static const String login = "Login";
  static const String warning = "Warning";
  static const String provideContact =
      "Please provide either email or phone number";
  static const String appBarLoginImage = 'assets/images/Banner2.png';
  static const String sendOtpUrl = 'http://172.20.10.5:3000/auth/sendotp';
  static const String otpVerifyUrl = 'http://172.20.10.5:3000/auth/verifyotp';
  static const String updateUserUrl =
      'http://172.20.10.5:3000/auth/updateuserinfo';

  static const String enterOtpSentTo = 'Enter the OTP sent to';
  static const String resendOtpIn = 'Resend OTP In: ';
  static const String verifyButtonText = 'Verify';
  static const String noArgumentsError = 'Error: No arguments provided';
  static const String otpBanner = 'assets/images/OTP_Banner.jpeg';

  static const String myProfile = 'My Profile';
  static const String profnickname = 'John Doe';
  static const String genderMale = 'male';
  static const String genderFemale = 'female';
  static const String genderOther = '';
  static const String chatsCompleted = '80+ chats completed';
  static const String connectMessage = 'Let\'s Connect and Help Each Other';
  static const String avatarImagePath = 'assets/images/avatar7.png';
  static const String profileBannerPath =
      'assets/images/INBOXPROFILEBANNER.jpg';
  static const String hyggeBannerPath = 'assets/images/Hygge_Text_Banner.png';
}

// Colors
class AppColors {
  static const Color gradientStart = Color(0xFF9431A5);
  static const Color gradientMiddle = Color(0xFFAC303B);
  static const Color gradientEnd = Color(0xFFF3BB1C);
  static const Color progressBarBackground = Color(0xFFAC303B);
  static const Color progressBarValue = Color(0xFF9431A5);
  static const Color maleColor = Colors.blue;
  static const Color femaleColor = Colors.pinkAccent;
  static const Color otherColor = Colors.orange;
  static const Color textColor = Colors.black;
  static const Color editIconColor = Colors.black38;
}

// Images
class AppImages {
  static const String onboarding1 = "assets/images/Onboarding_1.jpeg";
  static const String onboarding2 = "assets/images/people.jpg";
  static const String onboarding3 = "assets/images/Onboarding_3.jpeg";
}

// Keys
class AppKeys {
  static const String keyLogin = "Login";
}

// Other constants
class AppConstants {
  static const int otpDigits = 4;
  static const Duration otpResendInterval = Duration(seconds: 60);
}

class AppDimensions {
  static const double avatarRadius = 60.0;
  static const double appBarHeight = 60.0;
  static const double toolbarHeight = 60.0;
  static const double iconSize = 14.0;
  static const double genderIconSize = 26.0;
  static const double bannerHeight = 150.0;
  static const double bannerWidth = 250.0;
  static const double hyggeBannerHeight = 20.0;
  static const double hyggeBannerWidth = 40.0;
}

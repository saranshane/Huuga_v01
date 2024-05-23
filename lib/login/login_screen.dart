import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/login/otp_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login/constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final storedText = ''.obs; // Use RxString for reactive storedText
  String completePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarContent(), // Added the AppBarContent widget here
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding + 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.welcomeBack,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(
                        AppStrings.loginToContinue,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: AppStrings.email,
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20,
                        child: Center(
                          child: Text(
                            AppStrings.or,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      IntlPhoneField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: AppStrings.mobileNumber,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          completePhoneNumber =
                              phone.completeNumber.replaceAll('+', '');
                          print(completePhoneNumber);
                        },
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          String type;
                          String contact;

                          if (emailController.text.isNotEmpty) {
                            type = 'email';
                            contact = emailController.text;
                          } else if (completePhoneNumber.isNotEmpty) {
                            type = 'phoneNumber';
                            contact = completePhoneNumber;
                          } else {
                            // Show snackbar if neither email nor phone number is provided
                            Get.snackbar(
                              AppStrings.warning,
                              AppStrings.provideContact,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          _saveText(contact); // Save text to SharedPreferences

                          // Call the function to send OTP
                          sendOTP(type, contact);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientMiddle,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            constraints:
                                BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.login,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendOTP(String type, String contact) async {
    // Use the URL from constants
    String url = AppStrings.sendOtpUrl;

    // Prepare the request body as a Map
    Map<String, String> body = {"type": type, "contact": contact};
    print('Sending OTP with type: $type and contact: $contact');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json"
        }, // Specify content type as JSON
        body: jsonEncode(body), // Encode the body to JSON format
      );

      if (response.statusCode == 200) {
        // Response received successfully
        Map<String, dynamic> data = jsonDecode(response.body);
        print('Response: ${data["message"]}');

        // Navigate to the OTP screen
        Get.to(OtpScreen(), arguments: {'type': type, 'contact': contact});
      } else {
        // Error handling if OTP sending failed
        print('Failed to send OTP. Error: ${response.body}');
      }
    } catch (error) {
      // Handle any connection errors
      print('Failed to connect to the server. Error: $error');
    }
  }

  void _saveText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('storedText', text); // Save text to SharedPreferences
    storedText.value = text; // Update storedText value reactively
  }
}

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppStrings.appBarLoginImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

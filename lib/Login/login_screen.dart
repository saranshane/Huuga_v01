import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/login/otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final storedText = ''.obs; // Use RxString for reactive storedText

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarContent(), // Added the AppBarContent widget here
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login to continue',
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
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                          child: Center(
                            child: Text(
                              'OR',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: phoneNumberController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            String type;
                            String contact;

                            if (emailController.text.isNotEmpty) {
                              type = 'email';
                              contact = emailController.text;
                            } else if (phoneNumberController.text.isNotEmpty) {
                              type = 'phoneNumber';
                              contact = phoneNumberController.text;
                            } else {
                              // Show snackbar if neither email nor phone number is provided
                              Get.snackbar(
                                'Warning',
                                'Please provide either email or phone number',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            _saveText(
                                contact); // Save text to SharedPreferences

                            // Call the function to send OTP
                            sendOTP(type, contact);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // Apply gradient
                            textStyle: TextStyle(color: Colors.white),
                            // Apply text color
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF9431A5),
                                  Color(0xFFAC303B),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: 88.0, minHeight: 36.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
    // Define your backend URL
    String url = 'http://172.20.10.5:3000/auth/sendotp';

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
          image: AssetImage('assets/images/Banner2.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login/app/controllers/login_controller.dart';
import 'package:login/app/data/constants/constants.dart';
import 'package:login/app/views/login/appbar_content.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarContent(),
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
                        controller: loginController.emailController,
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
                        controller: loginController.phoneNumberController,
                        decoration: InputDecoration(
                          labelText: AppStrings.mobileNumber,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          loginController.completePhoneNumber =
                              phone.completeNumber.replaceAll('+', '');
                          print(loginController.completePhoneNumber);
                        },
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          String type;
                          String contact;

                          if (loginController.emailController.text.isNotEmpty) {
                            type = 'email';
                            contact = loginController.emailController.text;
                          } else if (loginController
                              .completePhoneNumber.isNotEmpty) {
                            type = 'phoneNumber';
                            contact = loginController.completePhoneNumber;
                          } else {
                            Get.snackbar(
                              AppStrings.warning,
                              AppStrings.provideContact,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          loginController.saveText(contact);
                          loginController.sendOTP(type, contact);
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
}

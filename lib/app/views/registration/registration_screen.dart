import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/registration_controller.dart';
import 'package:login/app/data/constants/constants.dart';
import 'package:login/app/widgets/appbar_content.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    final String userId = arguments['userId'];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarContent(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.completeProfile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        AppStrings.fillDetails,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        AppStrings.nickname,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          registrationController.nickname.value = value;
                        },
                        decoration: InputDecoration(
                          labelText: AppStrings.enterNickname,
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppStrings.gender,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(() => Wrap(
                            spacing: 5.0,
                            children: [
                              genderChoiceChip(
                                label: AppStrings.male,
                                gender: 'male',
                              ),
                              genderChoiceChip(
                                label: AppStrings.female,
                                gender: 'female',
                              ),
                              genderChoiceChip(
                                label: AppStrings.other,
                                gender: 'other',
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
                      Text(
                        AppStrings.aboutMe,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          registrationController.description.value = value;
                        },
                        decoration: InputDecoration(
                          labelText: AppStrings.enterText,
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            String nickname =
                                registrationController.nickname.value;
                            String gender =
                                registrationController.selectedGender.value;
                            String description =
                                registrationController.description.value;
                            if (nickname.isNotEmpty &&
                                gender.isNotEmpty &&
                                description.isNotEmpty) {
                              registrationController.submitProfileDetails(
                                  userId, nickname, gender, description);
                            } else {
                              print('Please fill up all fields');
                              // Display error message to user
                            }
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
                              constraints: BoxConstraints(
                                  minWidth: 88.0, minHeight: 36.0),
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.continueButton,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
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

  Widget genderChoiceChip({required String label, required String gender}) {
    return ChoiceChip(
      label: Text(label),
      selected: registrationController.selectedGender.value == gender,
      onSelected: (selected) {
        registrationController.updateSelectedGender(gender);
      },
    );
  }
}
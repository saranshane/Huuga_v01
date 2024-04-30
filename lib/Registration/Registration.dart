import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/Homescreen/Homescreen.dart';

class Registration extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> submitProfileDetails(
      String userId, String nickname, String gender, String description) async {
    try {
      final Uri url = Uri.parse('http://172.20.10.3:3000/auth/updateuserinfo');
      final Map<String, String> body = {
        'userId': userId,
        'name': nickname,
        'gender': gender,
        'details': description,
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        saveDataToSharedPreferences(nickname, gender, description);
        print('User info updated successfully');
        print(response.body);
        Get.to(Homescreen());
      } else {
        print('Failed to update user details. Error: ${response.body}');
        // Handle error
      }
    } catch (error) {
      print('Error updating user details: $error');
      // Handle error
    }
  }

  Future<void> saveDataToSharedPreferences(
      String nickname, String gender, String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
    await prefs.setString('gender', gender);
    await prefs.setString('description', description);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
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
                        "Complete Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Please fill up the details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Nickname",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          profileController.nickname.value = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Your Nickname',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Gender",
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
                                label: 'Male',
                                gender: 'male',
                              ),
                              genderChoiceChip(
                                label: 'Female',
                                gender: 'female',
                              ),
                              genderChoiceChip(
                                label: 'Other',
                                gender: 'other',
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
                      Text(
                        "About Me",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          profileController.description.value = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter The Text',
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            String nickname = profileController.nickname.value;
                            String gender =
                                profileController.selectedGender.value;
                            String description =
                                profileController.description.value;
                            if (nickname.isNotEmpty &&
                                gender.isNotEmpty &&
                                description.isNotEmpty) {
                              submitProfileDetails(
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
                              child: Text('Continue',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
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
      selected: profileController.selectedGender.value == gender,
      onSelected: (selected) {
        profileController.updateSelectedGender(gender);
      },
    );
  }
}

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Fill_up_Profile.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ProfileController extends GetxController {
  RxString selectedGender = 'Male'.obs;
  RxString nickname = ''.obs;
  RxString description = ''.obs;

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }
}

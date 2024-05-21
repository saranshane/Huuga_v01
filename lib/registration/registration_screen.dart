// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login/on_boarding/entry_screen.dart';
// import 'package:login/home/home_screen.dart';

// class RegistrationController extends GetxController {
//   var selectedGender = 'Male'.obs; // Observable variable for selected gender
//   var nickname = ''.obs; // Observable variable for nickname
//   var description = ''.obs; // Observable variable for description

//   // Function to update selected gender
//   void updateSelectedGender(String gender) {
//     selectedGender.value = gender;
//   }

//   // Function to submit profile details to the server
//   Future<void> submitProfileDetails(
//       String userId, String nickname, String gender, String description) async {
//     try {
//       final Uri url = Uri.parse('http://172.20.10.5:3000/auth/updateuserinfo');
//       final Map<String, String> body = {
//         'userId': userId,
//         'name': nickname,
//         'gender': gender,
//         'details': description,
//       };

//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         await saveDataToSharedPreferences(
//             nickname, gender, description); // Save data to SharedPreferences
//         print('User info updated successfully');
//         print(response.body);
//         Get.offAll(() =>
//             HomeScreen()); // Navigate to HomeScreen after successful update
//       } else {
//         print('Failed to update user details. Error: ${response.body}');
//         // Handle error
//       }
//     } catch (error) {
//       print('Error updating user details: $error');
//       // Handle error
//     }
//   }

//   // Function to save data to SharedPreferences
//   Future<void> saveDataToSharedPreferences(
//       String nickname, String gender, String description) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nickname', nickname);
//     await prefs.setString('gender', gender);
//     await prefs.setString('description', description);
//     await prefs.setBool(EntryScreen.keyLogin, true); // Set login status
//   }
// }

// class Registration extends StatelessWidget {
//   final RegistrationController registrationController =
//       Get.put(RegistrationController());

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> arguments = Get.arguments;
//     final String userId = arguments['userId'];
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             AppBarContent(), // Display app bar content
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(0),
//                     topRight: Radius.circular(0),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Complete Profile",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         "Please fill up the details",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       SizedBox(height: 25),
//                       Text(
//                         "Nickname",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         onChanged: (value) {
//                           registrationController.nickname.value = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Enter Your Nickname',
//                           prefixIcon: Icon(Icons.person_outline),
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Gender",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Obx(() => Wrap(
//                             spacing: 5.0,
//                             children: [
//                               genderChoiceChip(
//                                 label: 'Male',
//                                 gender: 'male',
//                               ),
//                               genderChoiceChip(
//                                 label: 'Female',
//                                 gender: 'female',
//                               ),
//                               genderChoiceChip(
//                                 label: 'Other',
//                                 gender: 'other',
//                               ),
//                             ],
//                           )),
//                       SizedBox(height: 10),
//                       Text(
//                         "About Me",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         onChanged: (value) {
//                           registrationController.description.value = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Enter The Text',
//                           prefixIcon: Icon(Icons.description),
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             String nickname =
//                                 registrationController.nickname.value;
//                             String gender =
//                                 registrationController.selectedGender.value;
//                             String description =
//                                 registrationController.description.value;
//                             if (nickname.isNotEmpty &&
//                                 gender.isNotEmpty &&
//                                 description.isNotEmpty) {
//                               registrationController.submitProfileDetails(
//                                   userId, nickname, gender, description);
//                             } else {
//                               print('Please fill up all fields');
//                               // Display error message to user
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             padding: EdgeInsets.zero,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xFF9431A5),
//                                   Color(0xFFAC303B),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.topRight,
//                               ),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Container(
//                               constraints: BoxConstraints(
//                                   minWidth: 88.0, minHeight: 36.0),
//                               alignment: Alignment.center,
//                               child: Text('Continue',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.white)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget for gender choice chip
//   Widget genderChoiceChip({required String label, required String gender}) {
//     return ChoiceChip(
//       label: Text(label),
//       selected: registrationController.selectedGender.value == gender,
//       onSelected: (selected) {
//         registrationController.updateSelectedGender(gender);
//       },
//     );
//   }
// }

// class AppBarContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 320,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//               'assets/images/Fill_up_Profile.jpeg'), // Set app bar background image
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/home/home_screen.dart';
import 'package:login/constants.dart'; // Import the constants file

class RegistrationController extends GetxController {
  var selectedGender = AppStrings.male.obs;
  var nickname = ''.obs;
  var description = ''.obs;

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> submitProfileDetails(
      String userId, String nickname, String gender, String description) async {
    try {
      final Uri url = Uri.parse('http://172.20.10.5:3000/auth/updateuserinfo');
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
        await saveDataToSharedPreferences(nickname, gender, description);
        print('User info updated successfully');
        print(response.body);
        Get.offAll(() => HomeScreen());
      } else {
        print('Failed to update user details. Error: ${response.body}');
      }
    } catch (error) {
      print('Error updating user details: $error');
    }
  }

  Future<void> saveDataToSharedPreferences(
      String nickname, String gender, String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
    await prefs.setString('gender', gender);
    await prefs.setString('description', description);
    await prefs.setBool(AppKeys.keyLogin, true);
  }
}

class RegistrationScreen extends StatelessWidget {
  final RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String userId = arguments['userId'];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarContent(), // Display app bar content
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

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppStrings.appBarImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

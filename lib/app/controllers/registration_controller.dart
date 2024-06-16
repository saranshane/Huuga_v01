import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/app/data/constants/constants.dart';
import 'package:login/app/views/registration/disclamer_screen.dart';

class RegistrationController extends GetxController {
  var selectedGender = AppStrings.male.obs;
  var nickname = ''.obs;
  var description = ''.obs;

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> submitProfileDetails(
      String userId, String nickname, String gender, String description) async {
    String updateurl = AppStrings.updateUserUrl;

    try {
      final Uri url = Uri.parse(updateurl);
      final Map<String, String> body = {
        'userId': userId,
        'name': nickname,
        'gender': gender,
        'details': description,
      };

      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        await saveDataToSharedPreferences(
            userId, nickname, gender, description);
        print('User info updated successfully');
        print(response.body);
        Get.offAll(() => DisclaimerScreen());
      } else {
        print('Failed to update user details. Error: ${response.body}');
      }
    } catch (error) {
      print('Error updating user details: $error');
    }
  }

  Future<void> saveDataToSharedPreferences(
      String userId, String nickname, String gender, String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId); // Save userId
    await prefs.setString('nickname', nickname);
    await prefs.setString('gender', gender);
    await prefs.setString('description', description);
    await prefs.setBool(AppKeys.keyLogin, true);
  }
}

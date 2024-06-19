// profile_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/app/data/models/profile_user_model.dart';
import 'package:login/app/data/constants/constants.dart';

class ProfileController extends GetxController {
  var user = UserModel(
    nickname: AppStrings.profnickname,
    gender: AppStrings.genderOther,
    description: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user.update((val) {
      val?.nickname = prefs.getString('nickname') ?? AppStrings.profnickname;
      val?.gender = prefs.getString('gender') ?? AppStrings.genderOther;
      val?.description = prefs.getString('description') ?? '';
    });
  }

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', user.value.nickname);
    await prefs.setString('gender', user.value.gender);
    await prefs.setString('description', user.value.description);
  }

  Future<void> updateNickname(String newNickname) async {
    user.update((val) {
      val?.nickname = newNickname;
    });
    await saveUserData();
  }

  Future<void> updateDescription(String newDescription) async {
    user.update((val) {
      val?.description = newDescription;
    });
    await saveUserData();
  }

  Future<void> updateGender(String newGender) async {
    user.update((val) {
      val?.gender = newGender;
    });
    await saveUserData();
  }
}

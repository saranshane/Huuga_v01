// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/profile_controller.dart';
import 'package:login/app/views/home/home_screen.dart';
import 'package:login/app/data/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.to(HomeScreen()); // Navigate back to HomeScreen
          },
        ),
        title: Text(AppStrings.myProfile),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings), // Icon for settings
            onPressed: () {
              // Get.to(SettingsScreen()); // Navigate to settings screen
            },
          ),
        ],
        toolbarHeight: AppDimensions.toolbarHeight,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: AppDimensions.avatarRadius,
                      backgroundImage: AssetImage(AppStrings.avatarImagePath),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: controller.user.value.gender,
                          icon: Icon(Icons.arrow_drop_down,
                              size: AppDimensions.iconSize),
                          iconSize: AppDimensions.iconSize,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.editIconColor),
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              await controller.updateGender(newValue);
                            }
                          },
                          items: <String>[
                            AppStrings.genderMale,
                            AppStrings.genderFemale,
                            AppStrings.genderOther,
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: _buildGenderIcon(value),
                            );
                          }).toList(),
                        ),
                        Text(
                          controller.user.value.nickname,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: Icon(Icons.edit,
                              size: AppDimensions.iconSize,
                              color: AppColors.editIconColor),
                          onPressed:
                              _editNickname, // Edit nickname functionality
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified,
                            size: AppDimensions.iconSize,
                            color: AppColors.femaleColor),
                        Text(
                          AppStrings.chatsCompleted,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            controller.user.value.description,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit,
                              size: AppDimensions.iconSize,
                              color: AppColors.editIconColor),
                          onPressed:
                              _editDescription, // Edit description functionality
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: AppDimensions.bannerHeight,
              width: AppDimensions.bannerWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppStrings.profileBannerPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppStrings.hyggeBannerPath,
                    height: AppDimensions.hyggeBannerHeight,
                    width: AppDimensions.hyggeBannerWidth,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    AppStrings.connectMessage,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.femaleColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  // Function to edit nickname
  void _editNickname() async {
    final ProfileController controller = Get.find();
    String newNickname =
        await _showEditDialog('Edit Nickname', controller.user.value.nickname);
    if (newNickname.isNotEmpty) {
      await controller.updateNickname(newNickname);
    }
  }

  // Function to edit description
  void _editDescription() async {
    final ProfileController controller = Get.find();
    String newDescription = await _showEditDialog(
        'Edit Description', controller.user.value.description);
    if (newDescription.isNotEmpty) {
      await controller.updateDescription(newDescription);
    }
  }

  // Function to show edit dialog
  Future<String> _showEditDialog(String title, String currentValue) async {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    return await showDialog<String>(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter new value'),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop('');
                  },
                ),
                TextButton(
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                ),
              ],
            );
          },
        ) ??
        '';
  }

  // Widget to build gender icon based on gender
  Widget _buildGenderIcon(String gender) {
    IconData icon;
    Color color;

    switch (gender) {
      case AppStrings.genderMale:
        icon = Icons.male_rounded;
        color = AppColors.maleColor;
        break;
      case AppStrings.genderFemale:
        icon = Icons.female_rounded;
        color = AppColors.femaleColor;
        break;
      default:
        icon = Icons.transgender;
        color = AppColors.otherColor;
        break;
    }

    return Icon(icon, size: AppDimensions.genderIconSize, color: color);
  }
}

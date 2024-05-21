import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/home/home_screen.dart';
import 'package:login/settings/settings_screen.dart'; // Import settings screen
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/constants.dart'; // Import the constants file

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String nickname;
  late String gender;
  late String description;

  @override
  void initState() {
    super.initState();
    loadUserData(); // Load user data when the screen initializes
  }

  // Function to load user data from SharedPreferences
  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nickname = prefs.getString('nickname') ??
          AppStrings.profnickname; // Set default nickname if not available
      gender = prefs.getString('gender') ??
          AppStrings.genderOther; // Set default gender if not available
      description = prefs.getString('description') ??
          ''; // Set default description if not available
    });
  }

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
              Get.to(SettingsScreen()); // Navigate to settings screen
            },
          ),
        ],
        toolbarHeight:
            AppDimensions.toolbarHeight, // Adjust this value as needed
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: AppDimensions.avatarRadius,
                    backgroundImage: AssetImage(
                        AppStrings.avatarImagePath), // Display user avatar
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGenderIcon(gender), // Display gender icon
                      Text(
                        nickname,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: AppDimensions.iconSize,
                            color: AppColors
                                .editIconColor), // Icon for editing nickname
                        onPressed: () {
                          // Add functionality to edit nickname
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified,
                          size: AppDimensions.iconSize,
                          color: AppColors.femaleColor), // Verified icon
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
                          description, // Display user description
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: AppDimensions.iconSize,
                            color: AppColors
                                .editIconColor), // Icon for editing description
                        onPressed: () {
                          // Add functionality to edit description
                        },
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
                image: AssetImage(
                    AppStrings.profileBannerPath), // Display profile banner
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
                  AppStrings.hyggeBannerPath, // Hygge text banner
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
                    color: AppColors.femaleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build gender icon based on gender
  Widget _buildGenderIcon(String gender) {
    IconData icon;
    Color color;

    switch (gender) {
      case AppStrings.genderMale:
        icon = Icons.male_rounded; // Male icon
        color = AppColors.maleColor;
        break;
      case AppStrings.genderFemale:
        icon = Icons.female_rounded; // Female icon
        color = AppColors.femaleColor;
        break;
      default:
        icon = Icons.transgender; // Transgender icon
        color = AppColors.otherColor;
        break;
    }

    return Icon(icon,
        size: AppDimensions.genderIconSize, color: color); // Return gender icon
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Homescreen/Home_Screen.dart';
import 'package:login/Settings/Settings_Screen.dart'; // Import settings screen
import 'package:shared_preferences/shared_preferences.dart';

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
          'John Doe'; // Set default nickname if not available
      gender = prefs.getString('gender') ??
          ''; // Set default gender if not available
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
            Get.to(Homescreen()); // Navigate back to HomeScreen
          },
        ),
        title: Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings), // Icon for settings
            onPressed: () {
              Get.to(settingsScreen()); // Navigate to settings screen
            },
          ),
        ],
        toolbarHeight: 60, // Adjust this value as needed
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
                    radius: 60,
                    backgroundImage: AssetImage(
                        'assets/images/avatar7.png'), // Display user avatar
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
                            size: 14,
                            color: Colors.black38), // Icon for editing nickname
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
                          size: 14, color: Colors.pinkAccent), // Verified icon
                      Text(
                        '80+ chats completed',
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
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.black38,
                        ), // Icon for editing description
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
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/INBOXPROFILEBANNER.jpg'), // Display profile banner
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
                  'assets/images/Hygge_Text_Banner.png', // Hygge text banner
                  height: 20,
                  width: 40,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Let\'s Connect and Help Each Other',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
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
      case 'male':
        icon = Icons.male_rounded; // Male icon
        color = Colors.blue;
        break;
      case 'female':
        icon = Icons.female_rounded; // Female icon
        color = Colors.pinkAccent;
        break;
      default:
        icon = Icons.transgender; // Transgender icon
        color = Colors.orange;
        break;
    }

    return Icon(icon, size: 26, color: color); // Return gender icon
  }
}

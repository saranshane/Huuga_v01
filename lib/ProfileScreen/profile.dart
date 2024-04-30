import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Homescreen/Homescreen.dart';
import 'package:login/settings/settings.dart';
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
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nickname = prefs.getString('nickname') ?? 'John Doe';
      gender = prefs.getString('gender') ?? '';
      description = prefs.getString('description') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.to(Homescreen());
          },
        ),
        title: Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(settingsScreen());
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
                    backgroundImage: AssetImage('assets/images/avatar7.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGenderIcon(gender),
                      Text(
                        nickname,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, size: 14, color: Colors.black38),
                        onPressed: () {
                          // Add functionality to edit nickname
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified, size: 14, color: Colors.pinkAccent),
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
                          description,
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
                        ),
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
                image: AssetImage('assets/images/INBOXPROFILEBANNER.jpg'),
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
                  'assets/images/Hygge_Text_Banner.png',
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

  Widget _buildGenderIcon(String gender) {
    IconData icon;
    Color color;

    switch (gender) {
      case 'male':
        icon = Icons.male_rounded;
        color = Colors.blue;
        break;
      case 'female':
        icon = Icons.female_rounded;
        color = Colors.pinkAccent;
        break;
      default:
        icon = Icons.transgender;
        color = Colors.orange;
        break;
    }

    return Icon(icon, size: 26, color: color);
  }
}

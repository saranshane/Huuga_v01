import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: controller.navigateToProfileScreen,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: controller.navigateToProfileScreen,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildListItem(
                  context,
                  Icons.login,
                  'Updated your login',
                  'Update your contact details',
                  () {
                    controller.showUpdateLoginDialog(context);
                  },
                ),
                _buildListItem(
                  context,
                  Icons.feedback_sharp,
                  'Share Feedback',
                  'Let us know how we can improve',
                  () {
                    controller.showFeedbackDialog(context);
                  },
                ),
                _buildListItem(
                  context,
                  Icons.delete_rounded,
                  'Delete Account',
                  'Delete account from Hüuga',
                  () {
                    // Add action for "Delete Account" item
                  },
                ),
                _buildListItem(
                  context,
                  Icons.logout,
                  'Logout',
                  'Logout from Hüuga',
                  () {
                    // Add action for "Logout" item
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/settings_Banner.jpeg'),
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

  Widget _buildListItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF9431A5),
                    Color(0xFFAC303B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                icon,
                color: Colors.grey[200],
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

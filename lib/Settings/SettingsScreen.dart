import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Profile/ProfileScreen.dart';

class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
              onPressed: () {
                Get.to(ProfileScreen());
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Get.to(ProfileScreen());
            },
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
                      _showUpdateLoginDialog(context);
                    },
                  ),
                  _buildListItem(
                    context,
                    Icons.feedback_sharp,
                    'Share Feedback',
                    'Let us know how we can improve',
                    () {
                      _showFeedbackDialog(context);
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

  void _showUpdateLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align text to the left
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/Hygge_Text_Banner.png', // Replace this with your image path
                  height: 25, // Adjust height as needed
                ),
              ),
              SizedBox(height: 1), // Add space between image and text field
              Text(
                "Let's connect and help each other",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.pink,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Add space between text and text field
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Text(
                  'Enter new phone number',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4), // Add space between text and text field
              TextField(
                keyboardType: TextInputType.phone, // Set keyboard type to phone
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number', // Update hint text
                  prefixIcon: Icon(Icons.phone), // Prefix icon
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border appearance when focused
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border appearance when enabled
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color(0xFF9431A5), width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    // Border appearance on error
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    // Border appearance on focused error
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  // You can add more customization based on your requirements
                ),
              ),
              SizedBox(height: 20), // Add space between text field and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Add your onPressed logic here
                },
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
                    constraints:
                        BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Send OTP',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align text to the left
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/Hygge_Text_Banner.png', // Replace this with your image path
                  height: 25, // Adjust height as needed
                ),
              ),
              SizedBox(height: 1), // Add space between image and text field
              Text(
                "Let's connect and help each other",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.pink,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Add space between text and text field
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Text(
                  'Share Your feedback',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Text(
                  'Let Us Know how we can improve',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10), // Add space between text and text field
              TextField(
                decoration: InputDecoration(
                  // labelText: 'Enter your text',
                  // hintText: 'Type something here',
                  // prefixIcon: Icon(Icons.SPACE),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFF9431A5),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                keyboardType: TextInputType.text,
                maxLength: 150,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  // Add your onChanged function here
                },
              ),

              SizedBox(height: 20), // Add space between text field and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Add your onPressed logic here
                },
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
                    constraints:
                        BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

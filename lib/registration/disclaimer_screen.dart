import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/home/home_screen.dart';
import 'package:login/registration/registration_screen.dart';

class DisclaimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Disclaimer', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.to(RegistrationScreen());
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security),
                SizedBox(width: 8.0),
                Text(
                  'Anonymous | Secure | Empathetic',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Flexible(
              flex: 4,
              child: Image.asset('assets/images/Disclaimer.jpg'),
            ),
            Flexible(
              flex: 5,
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Huuga helps you de-stress & feel better about daily-life challenges, be it about relationships, academics, work, family or friends.',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Huuga is an anonymous & secure community to help each other, where only your real self matters. Asking or sharing any personal details is strictly prohibited including contact details, social media id, etc.',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Huuga is not an alternative for medical advice, diagnosis or treatment. Rather, it is to instantly make you feel better by talking it out.',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'The opinions, beliefs and viewpoints expressed by users anywhere within the app PeerChats, posts or comments do not reflect the opinion, belief or viewpoint of Huuga or its affiliates.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.to(HomeScreen());
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
                  constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                  alignment: Alignment.center,
                  child: Text(
                    'I understand & accept',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

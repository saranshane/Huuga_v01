import 'package:flutter/material.dart';
import 'package:login/onboarding/onboarding_screen.dart';
import 'package:lottie/lottie.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> _startTimer() async {
    await Future.delayed(Duration(seconds: 8));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => OnboardingScreen(),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            key: UniqueKey(), // Added key parameter
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9431A5),
              Color(0xFFAC303B),
              Color(0xFFF3BB1C),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(child: Container()), // Spacer
            Center(
              child: Container(
                height: 400.0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Lottie.asset("assets/images/Entryscreen_Lottie.json"),
                ),
              ),
            ),
            SizedBox(height: 20), // Adjust this value as needed
            Text(
              "Hüuga",
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              "CONNECT | FEEL | HEAL",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Expanded(child: Container()), // Spacer
            SizedBox(
              height: 10, // Adjust this value as needed
              child: LinearProgressIndicator(
                backgroundColor: Color(0xFFAC303B),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9431A5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

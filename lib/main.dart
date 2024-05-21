import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/bindings/bindings.dart'; // Import the bindings file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/EntryScreen', // Set initial route to onboarding screen
      getPages: appPages, // Use the pages from bindings.dart
    );
  }
}

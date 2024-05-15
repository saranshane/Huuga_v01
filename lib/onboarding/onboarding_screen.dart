import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Login/Login_Screen.dart'; // Import the Login screen class

// Controller for managing onboarding screen state
class OnboardingController extends GetxController {
  var currentPage = 0.obs; // Observable variable to track current page index

  // Function to update current page index
  void onPageChanged(int value) {
    currentPage.value = value;
  }
}

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller =
      Get.put(OnboardingController()); // Instance of OnboardingController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2), // Spacer widget for top spacing
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: controller.onPageChanged, // Page change callback
                itemBuilder: (context, index) => OnboardContent(
                  // Build onboarding content
                  image: demoData[index]["image"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(), // Spacer widget for dot indicators spacing
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    demoData.length,
                    (index) => DotIndicator(
                      isActive: index ==
                          controller.currentPage.value, // Set dot active state
                    ),
                  ),
                )),
            const Spacer(flex: 3), // Spacer widget for bottom button spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "  ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF9431A5), // Left side color
                          Color(0xFFAC303B), // Right side color
                        ],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,

                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          // Get.to(LoginScreen());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen())); // Navigate to LoginScreen
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data for onboarding screens
List<Map<String, dynamic>> demoData = [
  {
    "image": "assets/images/Onboarding_1.jpeg",
    "title": "Stay Anonymous",
    "text": "Lets's Connect and Help Each Other",
  },
  {
    "image": "assets/images/people.jpg",
    "title": "Express Your Feeling to Someone",
    "text":
        "Express yourself freely without any judgement\nor fear. Let Your imagination run wild!",
  },
  {
    "image": "assets/images/Onboarding_3.jpeg",
    "title": "Choose your Perfect Person",
    "text":
        "Easily find your type of person craving and\nyou’ll get delivery in wide range.",
  },
];

// Widget for dot indicator
class DotIndicator extends StatelessWidget {
  final bool isActive; // Whether the dot is active
  final Color activeColor; // Color of active dot
  final Color inActiveColor; // Color of inactive dot

  const DotIndicator({
    Key? key,
    required this.isActive,
    this.activeColor = Colors.black87,
    this.inActiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 8 : 6, // Set width based on active state
      height: isActive ? 8 : 6, // Set height based on active state
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? activeColor
            : inActiveColor, // Set color based on active state
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String? image, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child:
                Image.asset(image!), // Corrected to access the image property
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title!,
          style: TextStyle(
            fontSize: 24, // Example font size
            fontWeight: FontWeight.bold, // Example font weight
            // You can add more properties such as color, etc.
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text!,
          style: TextStyle(
            fontSize: 16, // Example font size
            // You can add more properties such as color, etc.
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

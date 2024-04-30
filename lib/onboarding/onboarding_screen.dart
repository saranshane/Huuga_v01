// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:login/Login/Login.dart'; // Import the Login screen class
// import 'onboard_content.dart';

// class OnboardingController extends GetxController {
//   var currentPage = 0.obs;

//   void onPageChanged(int value) {
//     currentPage.value = value;
//   }
// }

// class OnboardingScreen extends StatelessWidget {
//   final OnboardingController controller = Get.put(OnboardingController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             const Spacer(flex: 2),
//             Expanded(
//               flex: 14,
//               child: PageView.builder(
//                 itemCount: demoData.length,
//                 onPageChanged: controller.onPageChanged,
//                 itemBuilder: (context, index) => OnboardContent(
//                   image: demoData[index]["image"],
//                   title: demoData[index]["title"],
//                   text: demoData[index]["text"],
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Obx(() => Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     demoData.length,
//                     (index) => DotIndicator(
//                       isActive: index == controller.currentPage.value,
//                     ),
//                   ),
//                 )),
//             const Spacer(flex: 2),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.to(LoginScreen()); // Corrected the method call
//                 },
//                 child: Text("Get Started".toUpperCase()),
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> demoData = [
//   {
//     "image": "assets/images/Onboarding_1.jpeg",
//     "title": "Stay Anonymous",
//     "text": "Lets's Connect and Help Each Other",
//   },
//   {
//     "image": "assets/images/people.jpg",
//     "title": "Express Your Feeling to Someone",
//     "text":
//         "Express yourself freely without any judgement\nor fear. Let Your imagination run wild!",
//   },
//   {
//     "image": "assets/images/Onboarding_3.jpeg",
//     "title": "Choose your Perfect Person",
//     "text":
//         "Easily find your type of person craving and\nyou’ll get delivery in wide range.",
//   },
// ];

// class DotIndicator extends StatelessWidget {
//   final bool isActive;
//   final Color activeColor;
//   final Color inActiveColor;

//   const DotIndicator({
//     Key? key,
//     required this.isActive,
//     this.activeColor = Colors.black87,
//     this.inActiveColor = Colors.grey,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 5),
//       width: isActive ? 8 : 6,
//       height: isActive ? 8 : 6,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive ? activeColor : inActiveColor,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Login/Login.dart'; // Import the Login screen class
import 'onboard_content.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void onPageChanged(int value) {
    currentPage.value = value;
  }
}

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) => OnboardContent(
                  image: demoData[index]["image"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    demoData.length,
                    (index) => DotIndicator(
                      isActive: index == controller.currentPage.value,
                    ),
                  ),
                )),
            const Spacer(flex: 3),
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
                                  builder: (context) => LoginScreen()));
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

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inActiveColor;

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
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? activeColor : inActiveColor,
      ),
    );
  }
}

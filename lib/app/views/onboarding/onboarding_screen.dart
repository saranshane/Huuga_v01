import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/data/constants/app_colors.dart';
import 'package:login/app/data/models/oboarding_data.dart';
// import 'package:login/app/views/login_screen.dart';
import 'package:login/app/views/login/login_screen.dart';
import 'package:login/app/widgets/dot_indicator.dart';
import 'package:login/app/widgets/onboard_content.dart';
import 'package:login/app/controllers/onboarding_controller.dart';

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
                  image: demoData[index].image,
                  title: demoData[index].title,
                  text: demoData[index].text,
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  demoData.length,
                  (index) => DotIndicator(
                    isActive: index == controller.currentPage.value,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle skip action
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientMiddle,
                          ],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            Get.to(() => LoginScreen());
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

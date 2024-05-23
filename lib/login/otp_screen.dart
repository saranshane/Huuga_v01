import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:login/constants.dart';
import 'package:login/Registration/registration_screen.dart';

class OtpScreen extends StatelessWidget {
  final OtpVerificationController otpController =
      Get.put(OtpVerificationController());

  BoxDecoration verifyButtonDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.gradientStart, AppColors.gradientMiddle],
    ),
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;

    if (arguments == null) {
      return Scaffold(
        body: Center(
          child: Text(AppStrings.noArgumentsError),
        ),
      );
    }

    final String type = arguments['type'];
    final String contact = arguments['contact'];

    otpController.init(type, contact);

    return GetBuilder<OtpVerificationController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppStrings.otpBanner),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            AppStrings.enterOtpSentTo,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            contact,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              AppConstants.otpDigits,
                              (index) => SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: otpController.controllers[index],
                                  focusNode: otpController.focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  onChanged: (String value) {
                                    if (value.length == 1 &&
                                        index < AppConstants.otpDigits - 1) {
                                      otpController.focusNodes[index].unfocus();
                                      FocusScope.of(context).requestFocus(
                                          otpController.focusNodes[index + 1]);
                                    } else if (value.isEmpty && index > 0) {
                                      otpController.focusNodes[index].unfocus();
                                      FocusScope.of(context).requestFocus(
                                          otpController.focusNodes[index - 1]);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              otpController.resendOTP();
                            },
                            child: Obx(() => Text(
                                  '${AppStrings.resendOtpIn}${otpController.timerSeconds.value} seconds',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue),
                                )),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: verifyButtonDecoration,
                          child: TextButton(
                            onPressed: () {
                              String otp = otpController.controllers.fold(
                                  "",
                                  (previousValue, controller) =>
                                      previousValue + controller.text);
                              otpController.verifyOTP(otp, type, contact);
                            },
                            child: Text(
                              AppStrings.verifyButtonText,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: OtpScreen(),
  ));
}

class OtpVerificationController extends GetxController {
  late String type;
  late String contact;
  late RxInt timerSeconds;

  Timer? _timer;

  List<TextEditingController> controllers = List.generate(
    AppConstants.otpDigits,
    (index) => TextEditingController(),
  );

  List<FocusNode> focusNodes = List.generate(
    AppConstants.otpDigits,
    (index) => FocusNode(),
  );

  @override
  void onInit() {
    timerSeconds = AppConstants.otpResendInterval.inSeconds.obs;
    type = '';
    contact = '';
    super.onInit();
  }

  void init(String type, String contact) {
    this.type = type;
    this.contact = contact;
    startTimer();
  }

  void startTimer() {
    timerSeconds.value = AppConstants.otpResendInterval.inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resendOTP() {
    startTimer();
  }

  Future<void> verifyOTP(String otp, String type, String contact) async {
    try {
      String url = AppStrings.otpVerifyUrl;
      Map<String, String> body = {
        'type': type,
        'contact': contact,
        'otp': otp,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("OTP verified successfully");
        Map<String, dynamic> data = jsonDecode(response.body);
        String userId = data["user"]["_id"];
        print(userId);
        Get.to(RegistrationScreen(), arguments: {'userId': userId});

        timerSeconds.value = 0;
      } else {
        print('Error verifying OTP: ${response.body}');
      }
    } catch (error) {
      print('Error verifying OTP: $error');
    }
  }
}

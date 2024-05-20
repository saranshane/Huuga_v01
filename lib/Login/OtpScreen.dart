import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:login/Registration/Registration.dart';

class OtpVerificationController extends GetxController {
  late String type;
  late String contact;
  late RxInt timerSeconds;

  Timer? _timer;

  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  List<FocusNode> focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  @override
  void onInit() {
    timerSeconds = 60.obs; // Initialize timerSeconds with 60 seconds
    type = '';
    contact = '';
    super.onInit();
  }

  void init(String type, String contact) {
    this.type = type;
    this.contact = contact;
    startTimer(); // Start the timer when initialized
  }

  void startTimer() {
    timerSeconds.value = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resendOTP() {
    // Implement logic to resend OTP
    startTimer();
  }

  Future<void> verifyOTP(String otp, String type, String contact) async {
    try {
      String url = 'http://172.20.10.5:3000/auth/verifyotp';
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
        // OTP verified successfully
        print("OTP verified successfully");
        Map<String, dynamic> data = jsonDecode(response.body);
        String userId = data["user"]["_id"];
        print(userId);
        // Navigate to the ProfileScreen and pass user ID as an argument
        Get.to(Registration(), arguments: {'userId': userId});

        // Reset the timer upon successful OTP verification
        timerSeconds.value = 0;

        // Handle success scenario
      } else {
        // OTP verification failed
        print('Error verifying OTP: ${response.body}');

        // Handle failure scenario
        // You can display an error message to the user here
      }
    } catch (error) {
      print('Error verifying OTP: $error');

      // Display error message to user
    }
  }
}

class OtpScreen extends StatelessWidget {
  final OtpVerificationController otpController =
      Get.put(OtpVerificationController());

  // Custom button style for the Verify button
  BoxDecoration verifyButtonDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF9431A5), Color(0xFFAC303B)],
    ),
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?; // Use '?' for null check
    if (arguments == null) {
      // Handle null arguments, such as showing an error message or navigating back
      return Scaffold(
        body: Center(
          child: Text('Error: No arguments provided'),
        ),
      );
    }

    final String type = arguments['type'];
    final String contact = arguments['contact'];

    // Start the timer when the screen opens
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
                      image: AssetImage('assets/images/OTP_Banner.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Enter the OTP sent to',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    contact,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 50,
                        child: TextField(
                          controller: otpController.controllers[index],
                          focusNode: otpController.focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          onChanged: (String value) {
                            if (value.length == 1 && index < 3) {
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
                          'Resend OTP In: ${otpController.timerSeconds.value} seconds',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: verifyButtonDecoration,
                  child: TextButton(
                    onPressed: () {
                      String otp = otpController.controllers.fold(
                          "",
                          (previousValue, controller) =>
                              previousValue + controller.text);
                      print("Entered OTP: $otp");
                      print(
                          "Type: $type, Contact: $contact"); // Print type and contact
                      otpController.verifyOTP(otp, type, contact);
                    },
                    child: Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
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

class OtpController extends GetxController {
  var timerSeconds = 60.obs;
  var controllers = List<TextEditingController>.generate(
      4, (index) => TextEditingController()).obs;
  var focusNodes = List<FocusNode>.generate(4, (index) => FocusNode()).obs;
  var timer = Timer(Duration.zero, () {});

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerSeconds.value == 0) {
          timer.cancel();
        } else {
          timerSeconds.value--;
        }
      },
    );
  }

  @override
  void onClose() {
    timer.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

class ProfileController extends GetxController {
  final selectedGender = RxString('');

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }
}

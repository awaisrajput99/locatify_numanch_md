import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/mail_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MdSizes.mdDefaultPadding),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Image.asset(
                  MdImages.mdMail,
                  height: size.height * 0.25,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "Verify Your Email Address",
                  style: TextStyle(fontFamily: "Roboto", fontSize: 30),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "We have just send email verification link on your email. Please check email and click on that link to verfiy your email address.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "If not auto redirected after verification, click on the continue button.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.manuallyCheckEmailVerificationStatus();
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 20, fontFamily: "Roboto"),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        // Set the elevation color to transparent
                        backgroundColor: Colors.transparent, // Background color
                        foregroundColor: Colors.blue, // Text color
                        elevation: 0, // Remove elevation
                        splashFactory: NoSplash.splashFactory, // Remove splash effect
                      ),
                      onPressed: () {
                        controller.reSendVerificationMail();

                      },
                      child: Text(
                        "Resend E-Mail Link",
                        style: TextStyle(fontSize: 15,fontFamily: 'roboto',color: Colors.blue),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        // Set the elevation color to transparent
                        backgroundColor: Colors.transparent, // Background color
                        foregroundColor: Colors.blue, // Text color
                        elevation: 0, // Remove elevation
                        splashFactory: NoSplash.splashFactory, // Remove splash effect
                      ),
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      child: Text(
                        "Back to Login",
                        style: TextStyle(fontSize: 15,fontFamily: 'roboto',color: Colors.blue),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

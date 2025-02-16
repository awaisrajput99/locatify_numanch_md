import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/features/authentication/controllers/google_authentication_controller.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
class SignupFormFooter extends StatelessWidget {
  const SignupFormFooter({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleAuthenticationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: size.height*0.01,),
        Obx(() => SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: controller.isgoogleLoading.value
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: MdAppColors.mdPrimaryColor,
              ),
            )
                : Image.asset(
              MdImages.mdGoogle,
              height: 27,
            ),
            onPressed: controller.isgoogleLoading.value
                ? null // Disable button when loading
                : () {
              controller.googleSingIn(context);
            },
            label: Text(
              controller.isgoogleLoading.value ? "Signing in..." : "Sign-in with Google",
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Roboto",
                fontSize: 18,
              ),
            ),
          ),
        )),
        SizedBox(height: size.height*0.0001,),
        TextButton(
            style: TextButton.styleFrom(
                overlayColor: Colors.white
            ),
            onPressed: (){
              Get.toNamed("/login");
            },
            child: const Text.rich(
              TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                            color: Colors.lightBlue
                        )
                    )
                  ]
              ),
            )
        )
      ],
    );
  }
}
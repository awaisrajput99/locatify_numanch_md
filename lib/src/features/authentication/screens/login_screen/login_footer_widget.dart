import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/loading_button/loading_button.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/features/authentication/controllers/google_authentication_controller.dart';

import '../../../../constants/image_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
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

        SizedBox(height: size.height*0.01,),
        TextButton(
            style: TextButton.styleFrom(
                overlayColor: Colors.white
            ),
            onPressed: (){
              Get.toNamed("/signup");
            },
            child: const Text.rich(
              TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                        text: "SignUp",
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
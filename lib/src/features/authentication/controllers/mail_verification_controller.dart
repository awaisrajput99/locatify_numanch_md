import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/repositey/authentication_repositery/authentication_repositery.dart';

class MailVerificationController extends GetxController{
late Timer _timer;
@override
void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendVerificationMail();
    setTimerForAutoRedirect();
  }

 Future<void> sendVerificationMail() async {
  try { }
  catch (e) {
   CustomToast.showErrorToast(e.toString());
  }
   await AuthenticationRepository.instance.sendEmailVerification();
  CustomToast.showSuccessfulToast("Mail has been sent");
 }

void setTimerForAutoRedirect() {
  _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
    await FirebaseAuth.instance.currentUser?.reload(); // Reload user to check verification status
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      timer.cancel(); // Stop the timer
      Get.offAllNamed("/dashboard");// Redirect to dashboard after verification
      CustomToast.showSuccessfulToast("Email has been successfully verified!");

    }
    // If not verified, stay on the email verification screen
  });
}

Future<void> reSendVerificationMail() async {
  try { }
  catch (e) {
    CustomToast.showErrorToast(e.toString());
  }
  await AuthenticationRepository.instance.sendEmailVerification();
  CustomToast.showSuccessfulToast("Verification mail has been sent again!");
}

void manuallyCheckEmailVerificationStatus() async {
  await FirebaseAuth.instance.currentUser?.reload();
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.emailVerified) {
    Get.offAllNamed("/dashboard");
    CustomToast.showSuccessfulToast("Email has been successfully verified!");
  } else {
    CustomToast.showErrorToast("Email not verified yet.");
  }
}
}
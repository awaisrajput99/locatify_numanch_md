import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/repositey/authentication_repositery/authentication_repositery.dart';

class GoogleAuthenticationController extends GetxController{
  static GoogleAuthenticationController get instance => Get.find();

  final isgoogleLoading  = false.obs;
  Future<void> googleSingIn(BuildContext context)async{
      isgoogleLoading.value = true;
      UserCredential? userCredential = await AuthenticationRepository.instance.signinWithGoogle(context);
      isgoogleLoading.value = false;
      if(userCredential != null){
        AuthenticationRepository.instance.navigateBasedOnState();
        CustomToast.showSuccessfulToast("Logged in Successfully!");
        return;
      }



  }
}
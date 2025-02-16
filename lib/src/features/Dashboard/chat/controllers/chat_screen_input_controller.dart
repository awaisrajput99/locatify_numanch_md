import 'package:get/get.dart';

class ChatScreenInputController extends GetxController {
  static ChatScreenInputController get instance => Get.find();

  RxBool isTyping = false.obs;

  void setIsTyping(bool value) {
    isTyping.value = value;
  }
}
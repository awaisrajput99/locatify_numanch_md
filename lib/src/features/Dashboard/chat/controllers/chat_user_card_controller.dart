import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatUserCardController extends GetxController{
  static ChatUserCardController get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
}
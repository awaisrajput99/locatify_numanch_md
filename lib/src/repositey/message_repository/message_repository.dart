import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageRepository extends GetxController{
  static MessageRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return _db.collection("Messages").snapshots();
  }
}
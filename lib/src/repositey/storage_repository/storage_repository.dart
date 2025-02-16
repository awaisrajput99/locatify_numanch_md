import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageRepository extends GetxController {
  static StorageRepository get to => Get.find();

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadImage(File file, String folderName) async {
    try {
      final ext = file.path.split('.').last;
      final userId = _auth.currentUser!.uid;
      final ref = _storage.ref().child('$folderName/$userId/${userId}.$ext');  // ✅ Matches rules

      await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null; // Return null in case of an error
    }
  }
}
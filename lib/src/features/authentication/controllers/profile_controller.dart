import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';
import 'package:locatify/src/repositey/authentication_repositery/authentication_repositery.dart';
import '../../../repositey/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final email = TextEditingController();
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user data once
  Future<MdUserModel?> getUserData() async {
    final user = _authRepo.firebaseUser.value;
    if (user != null) {
      return await _userRepo.getUserDetails(user.uid);
    } else {
      CustomToast.showErrorToast("Login to continue!");
      return null;
    }
  }

  // Update user record
  Future<void> updateRecord(MdUserModel user) async {
    await _userRepo.updateUserDetails(user);
  }

  // Stream for real-time updates
  Stream<MdUserModel> get userDataStream {
    final user = _authRepo.firebaseUser.value;
    if (user == null) {
      CustomToast.showErrorToast("User not authenticated");
      return const Stream.empty();
    }

    return _userRepo.getUserStream(user.uid).handleError((error) {
      CustomToast.showErrorToast("Error fetching user data: $error");
    });
  }

  /// 🛠 Function to update user image in Firestore
  Future<void> updateUserImage(String imageUrl) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) throw "User is not logged in";

      await _firestore.collection("Users").doc(uid).set({
        "image": imageUrl,
      }, SetOptions(merge: true)); // ✅ Ensures the document is created if it doesn’t exist
      CustomToast.showSuccessfulToast("Image updated successfully!");
    } catch (e) {
      print("🔥 Error updating user image: $e");
    }
  }
}
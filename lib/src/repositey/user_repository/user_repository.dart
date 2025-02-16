import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
  Future<void> createUser(MdUserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
      if(!auth.currentUser!.emailVerified){
        CustomToast.showSuccessfulToast("Account created! Please verify your email.");
      }
    } catch (error) {
      print("Error Creating Account: $error");
      CustomToast.showErrorToast("Error Creating Account: $error");
    }


  }

  Stream<MdUserModel> getUserStream(String uid) {
    return _db.collection("Users")
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return MdUserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
  }


  // user_repository.dart
  Future<MdUserModel> getUserDetails(String uid) async {
    final snapshot = await _db.collection("Users").doc(uid).get();
    if(snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return MdUserModel.fromJson(data);
    } else {
      throw Exception("User not found");
    }
  }

  Stream<List<MdUserModel>> getAllUsersStream() {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      return Stream.value([]); // Return an empty stream if no user is logged in
    }

    return _db
        .collection("Users")
        .where("id", isNotEqualTo: currentUserId) // ✅ Exclude the logged-in user
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MdUserModel.fromJson(doc.data())).toList();
    });
  }

  Future<void> updateUserDetails(MdUserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
    CustomToast.showSuccessfulToast("Profile Updated Successfully!");
  }
}
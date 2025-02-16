import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/flushbar/flushbar.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';
import 'package:locatify/src/repositey/exceptions/signin_with_google_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:locatify/src/repositey/exceptions/signup_email_password_failure.dart';

import '../../features/authentication/controllers/phone_auth_controller.dart';
import '../exceptions/login_email_password_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../user_repository/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final userController = Get.put(UserRepository());

  final _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);
  var mdVerificationId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(_auth.userChanges());
    navigateBasedOnState();
  }

  final time = DateTime.now().millisecondsSinceEpoch.toString();

  // Navigation logic with a splash screen delay
  Future<void> navigateBasedOnState() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      Get.offAllNamed("/onboarding");
    } else {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        Get.offAllNamed("/welcome");
      } else {
        if (firebaseUser.emailVerified) {
          Get.offAllNamed(
              "/dashboard"); // Redirect to dashboard if email is verified
        } else {
          Get.offAllNamed(
              "/emailVerificationScreen"); // Redirect to email verification screen if not verified
        }
      }
    }
  }

  // Handles user creation with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await sendEmailVerification(); // Send verification email
      Get.offAllNamed(
          "/emailVerificationScreen"); // Redirect to email verification screen
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailPasswordFailure.code(e.code);
      showFlushbar(context, ex.message);
      throw ex;
    } catch (e) {
      final ex = LoginWithEmailPasswordFailure();
      print("Login Error: $e");
      showFlushbar(context, ex.message);
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      // Sign in the user
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      CustomToast.showSuccessfulToast("Logged In Successfully!");

      // Check if the user's email is verified
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final bool isverified = await user.emailVerified;
        if (isverified) {
          // Email is verified, redirect to dashboard
          Get.offAllNamed("/dashboard");
        } else {
          // Email is not verified, redirect to email verification screen
          CustomToast.showErrorToast("Please verify your email to continue.");
          Get.offAllNamed("/emailVerificationScreen");
        }
      } else {
        // No user found, redirect to welcome screen
        Get.offAllNamed("/welcome");
      }
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailPasswordFailure.code(e.code);
      // Show the exception as a toast
      showFlushbar(context, ex.message);
      throw ex; // Optional: rethrow the exception if needed
    } catch (e) {
      final ex = LoginWithEmailPasswordFailure();
      print("Login Error: $e");
      showFlushbar(context, ex.message);
      throw ex;
    }
  }

  // Logs out the user
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      CustomToast.showSuccessfulToast("Logged Out!");
      Get.offAllNamed("/welcome");
    } catch (e) {
      print("Error logging out: $e");
      CustomToast.showErrorToast("Logout failed. Please try again.");
    }
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          try {
            await _auth.signInWithCredential(phoneAuthCredential);
            print("Phone number verified and user signed in.");
          } catch (e) {
            print("Error signing in with phoneAuthCredential: $e");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Phone verification failed: ${e.message}");
          CustomToast.showErrorToast("Phone verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          PhoneAuthController.instance.setVerificationId(verificationId);
          print("Verification code sent to $phoneNo.");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto-retrieval of verification code timed out.");
        },
      );
    } catch (e) {
      print("Error initiating phone number verification: $e");
    }
  }

  Future<void> otpVerification(String verificationId, String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      print("User successfully signed in with the SMS code.");
    } catch (e) {
      print("Error signing in with the SMS code: $e");
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailPasswordFailure.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = SignupWithEmailPasswordFailure();
      throw ex.message;
    }
  }

  Future<bool> userExists(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty; // Returns true if the email exists
  }

  Future<UserCredential?> signinWithGoogle(BuildContext context) async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels sign-in
      if (googleUser == null) {
        throw Exception("Sign-in process was canceled by the user.");
      }

      // Obtain Google authentication details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in the user
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      // ✅ First check if user is null
      if (user == null) {
        throw Exception("Failed to retrieve user details.");
      }

      // ✅ Check if user already exists in Firestore
      final bool userAlreadyExists = await userExists(user.email!);

      if (userAlreadyExists) {
        // ✅ If user exists, just log them in and return userCredential
        CustomToast.showSuccessfulToast("Login successful!");
        return userCredential;
      }

      // ✅ If user does not exist, create a new user entry in Firestore
      final mdUser = MdUserModel(
        id: user.uid,
        FullName: user.displayName ?? "Google User",
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "", // Prevents null.toString() issue
        password: "",
        image: user.photoURL ?? "",
        about: "I am a Google user",
        created_at: DateTime.now().toString(),
        last_active: DateTime.now().toString(),
        is_online: false,
        push_token: "",
      );

      // ✅ Save user to Firestore
      await userController.createUser(mdUser);

      // ✅ If everything is fine, return userCredential
      return userCredential;
    } on FirebaseAuthException catch (e) {
      CustomToast.showErrorToast("Authentication failed: ${e.message}");
      return null;
    } catch (e) {
      CustomToast.showErrorToast("Error: $e");
      return null;
    }
  }}

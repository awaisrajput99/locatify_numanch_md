import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locatify/src/repositey/authentication_repositery/authentication_repositery.dart';
import 'package:locatify/src/repositey/user_repository/user_repository.dart';

import '../models/user_model.dart';

class MdSignupController extends GetxController {
  static MdSignupController get instance => Get.find();

  // Controllers to get data from the text fields
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final confirmPassword = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // Validation methods for each field
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    if (value.length < 3) {
      return 'Full Name must be at least 3 characters long';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    String pattern = r'^\+?1?\d{9,15}$'; // E.164 phone number format
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Minimum length of 8 characters
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }


  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Method to handle user registration
  void registerUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, password, context);

      if (userCredential.user != null) {
        final user = MdUserModel(
          id: userCredential.user!.uid,
          FullName: fullName.text.trim(),
          email: email,
          phoneNumber: phone.text.trim(),
          password: password.trim(),
          about: 'feeling happy',
          created_at: DateTime.now().toString(),
          last_active: DateTime.now().toString(),
          is_online: true,
          image: "haohogh",
          push_token: "hahohoh",
        );

        await createUser(user); // Ensure this runs only after successful auth
      }
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  Future<void> createUser( MdUserModel user) async {
  await userRepo.createUser(user);
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../authentication/controllers/profile_controller.dart';
import '../../../authentication/models/user_model.dart';

class UpdateUserProfileForm extends StatelessWidget {
  final MdUserModel userdata;
  const UpdateUserProfileForm({
    required this.userdata,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final _formKey = GlobalKey<FormState>();
    // Set initial values in controllers
    controller.fullName.text = userdata.FullName;
    controller.email.text = userdata.email;
    controller.phoneNumber.text = userdata.phoneNumber;
    controller.password.text = userdata.password;

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TextFormField(
          controller: controller.fullName,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            prefixIcon: const Icon(Icons.person_outline_outlined),
            labelText: "Full Name",
          ),
        ),
        SizedBox(height: size.height * 0.015),
        TextFormField(
          controller: controller.email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            prefixIcon: const Icon(Icons.email_outlined),
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: size.height * 0.015),
        TextFormField(
          controller: controller.phoneNumber,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            prefixIcon: const Icon(Icons.numbers_outlined),
            labelText: "Phone Number",
          ),
        ),
        SizedBox(height: size.height * 0.015),
        TextFormField(
          controller: controller.password,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            prefixIcon: const Icon(Icons.fingerprint_outlined),
            labelText: "Password",
          ),
        ),
        SizedBox(height: size.height * 0.07),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide.none,
              backgroundColor: Colors.black,
            ),
            onPressed: () async {
                final userData = MdUserModel(
                  id: userdata.id,
                  FullName: controller.fullName.text.trim(),
                  email: controller.email.text.trim(),
                  phoneNumber: controller.phoneNumber.text.trim(),
                  password: controller.password.text.trim(),
                  image: userdata.image,
                  about: userdata.about,
                  created_at: userdata.created_at,
                  last_active: userdata.last_active,
                  is_online: userdata.is_online,
                  push_token: userdata.push_token,
                );

                await controller.updateRecord(userData);
                Get.back();


            },
            child: const Text(
              "Update",
              style: TextStyle(fontSize: 22, color: Colors.white, fontFamily: 'roboro'),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text:  TextSpan(
                text: "Joined ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    text: userdata.created_at,
                  ),
                ],
              ),
            ),

          ],
        ),
      ],
    );
  }
}
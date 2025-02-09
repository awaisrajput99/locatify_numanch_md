import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/sizes.dart';
import 'package:locatify/src/features/Dashboard/profile/widgets/update_user_profile_form.dart';

import '../../../constants/colors.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MdAppColors.mdPrimaryColor,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 25, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MdSizes.mdDefaultPadding),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://images.pexels.com/photos/388517/pexels-photo-388517.jpeg?auto=compress&cs=tinysrgb&w=800",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: MdAppColors.mdButtonColor.withOpacity(0.9),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Get.toNamed("/updateUserProfile");
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 25,
                              )))),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const UpdateUserProfileForm()
            ],
          ),
        ),
      ),
    );
  }
}


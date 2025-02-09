import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/constants/sizes.dart';
import 'package:locatify/src/features/Dashboard/profile/widgets/profile_menu.dart';

import '../../../repositey/authentication_repositery/authentication_repositery.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                Icons.edit,
                                size: 25,
                              ))))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Chu Chu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'roboto'),
              ),
              const Text("muhammadnumanarif04@gmail.com",
                  style: TextStyle(fontSize: 14)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: BorderSide.none,
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Get.toNamed("/updateUserProfile");
                      },
                      child: const Text("Edit profile",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'roboro')))),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: Colors.transparent,
              ),
              const SizedBox(
                height: 10,
              ),

              //menu
              ProfileMenu(
                title: "Settings",
                icon: Icons.settings,
                ontap: () {},
              ),
              ProfileMenu(
                title: "User Management",
                ontap: () {},
                icon: Icons.manage_accounts_rounded,
              ),
              ProfileMenu(
                title: "Help",
                ontap: () {},
                icon: Icons.help_outline,
              ),
              ProfileMenu(
                title: "Feedback",
                ontap: () {},
                icon: Icons.feedback,
              ),
              ProfileMenu(
                title: "Terms & Conditions",
                ontap: () {},
                icon: Icons.rule,
              ),
              const Divider(),
              ProfileMenu(
                title: "About",
                ontap: () {},
                icon: Icons.info,
              ),
              ProfileMenu(
                title: "Logout",
                ontap: () {
                  AuthenticationRepository.instance.logoutUser();
                },
                icon: Icons.exit_to_app,
                endIcon: false,
                textColor: Colors.red,
              ),
            ],
          )),
    );
  }
}

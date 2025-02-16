import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/constants/sizes.dart';
import 'package:locatify/src/features/Dashboard/profile/widgets/profile_menu.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

import '../../../repositey/authentication_repositery/authentication_repositery.dart';
import '../../authentication/controllers/profile_controller.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(MdSizes.mdDefaultPadding),
          child: Column(
            children: [
              StreamBuilder<MdUserModel>(
                stream: controller.userDataStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MdAppColors.mdPrimaryColor,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No user data available"),
                    );
                  }

                  final userdata = snapshot.data!;
                  return Column(
                    children: [
                      // Your existing profile UI components
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                userdata.image,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                onPressed: () => Get.toNamed("/updateUserProfile"),
                                icon: const Icon(Icons.edit, size: 25),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userdata.FullName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'roboto'
                        ),
                      ),
                      Text(userdata.email, style: TextStyle(fontSize: 14)),
                      // Rest of your profile UI...

                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Get.toNamed("/updateUserProfile");
                          },
                          child: const Text(
                            "Edit profile",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'roboto'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(color: Colors.transparent),
                      const SizedBox(height: 10),

                    ],
                  );
                },
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

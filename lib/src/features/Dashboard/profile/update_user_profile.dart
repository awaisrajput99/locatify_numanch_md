import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/common_widgets/flushbar/flushbar.dart';
import 'package:locatify/src/common_widgets/toast_messages/toast_message.dart';
import 'package:locatify/src/constants/sizes.dart';
import 'package:locatify/src/features/Dashboard/controllers/image_picker_controller.dart';
import 'package:locatify/src/features/Dashboard/profile/widgets/update_user_profile_form.dart';
import 'package:locatify/src/features/authentication/controllers/profile_controller.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';
import 'package:locatify/src/repositey/storage_repository/storage_repository.dart';

import '../../../constants/colors.dart';
import '../common_widgets_of_dashboard/image_picker_options_bottomsheet.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final imagePickerController = Get.put(ImagePickerController());
    final storageController = Get.put(StorageRepository());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MdAppColors.mdPrimaryColor,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 25, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MdSizes.mdDefaultPadding),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  MdUserModel userData = snapshot.data as MdUserModel;
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Obx(() {
                                 return imagePickerController.selectedImage.value !=
                                      null
                                      ? Image.file(
                                    imagePickerController
                                        .selectedImage.value!,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.network(
                                    userData.image,
                                    fit: BoxFit.cover,
                                  );
                                }
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
                                    color: MdAppColors.mdButtonColor
                                        .withOpacity(0.9),
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        // Wait for the user to select an image
                                        File? selectedImage = await ImagePickerOptionsBottomSheet.showImagePickerOptions(
                                            context, imagePickerController);

                                        // If an image was selected, upload it
                                        if (selectedImage != null) {
                                          String? imageUrl = await storageController.uploadImage(selectedImage, "profile_pictures");

                                          if (imageUrl != null) {
                                            // Update the user's profile image URL in Firestore
                                            await controller.updateUserImage(imageUrl);

                                          } else {
                                            CustomToast.showErrorToast("Failed to upload image. Try again.");
                                          }
                                        } else {
                                          CustomToast.showErrorToast("No image selected.");
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                      )
                                  )
                              )
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      UpdateUserProfileForm(
                        userdata: userData,
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MdAppColors.mdPrimaryColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: const StadiumBorder(),
          side: BorderSide.none,
        ),
        onPressed: () {},
        child: const Text(
          "Delete Account",
          style: TextStyle(
              color: Colors.white, fontFamily: 'roboto', fontSize: 20),
        ),
      ),
    );
  }
}

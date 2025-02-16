import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/image_picker_controller.dart';

class ImagePickerOptionsBottomSheet {
  static Future<File?> showImagePickerOptions(
      BuildContext context, ImagePickerController controller) async {
    return await showModalBottomSheet<File?>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Pick from Camera'),
              onTap: () async {
                File? image = await controller.pickImageFromCamera();
                Get.back(result: image); // Close bottom sheet and return image
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Pick from Gallery'),
              onTap: () async {
                File? image = await controller.pickImageFromGallery();
                Get.back(result: image); // Close bottom sheet and return image
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () {
                Get.back(result: null); // Close the bottom sheet with no selection
              },
            ),
          ],
        );
      },
    );
  }
}
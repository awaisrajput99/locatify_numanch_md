import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  // Selected image file (observable)
  var selectedImage = Rx<File?>(null);

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
        return selectedImage.value;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    return null;
  }

  // Function to pick an image from the camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImage.value = File(image.path);
        return selectedImage.value;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    return null;
  }

  // Clear the selected image
  void clearImage() {
    selectedImage.value = null;
  }
}
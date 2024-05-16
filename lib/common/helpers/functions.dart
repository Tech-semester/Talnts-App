import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talnts_app/common/widgets/colors.dart';


Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      print(pickedImage.name);
      image = File(pickedImage.path);
    }
  } catch (e) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Error',
        message: e.toString(),
        duration: const Duration(seconds: 4),
        backgroundColor: primaryColor,
      ),
    );
  }
  return image;
}


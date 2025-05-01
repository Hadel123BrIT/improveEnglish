// controllers/profile_controller.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final RxString name = 'John Doe'.obs;
  final RxString email = 'john@example.com'.obs;
  final RxString profileImageUrl = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> uploadProfileImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        isLoading(true);
        final File imageFile = File(pickedFile.path);

        // Upload to Firebase Storage
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final UploadTask uploadTask = storageRef.putFile(imageFile);
        final TaskSnapshot snapshot = await uploadTask;
        final String downloadUrl = await snapshot.ref.getDownloadURL();

        profileImageUrl.value = downloadUrl;

        // Here you would typically also update the URL in Firestore
        Get.snackbar('Success', 'Profile image updated!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
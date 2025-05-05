// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
//
// class ProfileController extends GetxController {
//   final RxString name = 'Hadel Brmo'.obs;
//   final RxString email = 'hadel@example.com'.obs;
//   final RxString imageUrl = ''.obs;
//   final RxBool isLoading = false.obs;
//
//   Future<void> uploadProfileImage() async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         isLoading(true);
//         final File imageFile = File(pickedFile.path);
//         final String fileName = basename(pickedFile.path);
//
//         final Reference ref = FirebaseStorage.instance.ref("profile_images/$fileName");
//         await ref.putFile(imageFile);
//         imageUrl.value = await ref.getDownloadURL();
//
//         Get.snackbar('Success', 'Profile image updated!');
//       }
//     } on FirebaseException catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: ${e.message}');
//     } catch (e) {
//       Get.snackbar('Error', 'An unexpected error occurred: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  // بيانات المستخدم
  final RxString name = 'Hadel Brmo'.obs;
  final RxString email = 'hadel@example.com'.obs;
  final RxString imagePath = ''.obs;
  final RxBool isLoading = false.obs;

  // مفاتيح التخزين
  static const String _imageKey = 'profile_image';

  @override
  void onInit() {
    super.onInit();
    _loadSavedImage();
  }

  // تحميل الصورة المحفوظة
  Future<void> _loadSavedImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPath = prefs.getString(_imageKey);
      if (savedPath != null && savedPath.isNotEmpty) {
        imagePath.value = savedPath;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load saved image');
    }
  }

  // اختيار وحفظ الصورة
  Future<void> pickAndSaveImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      isLoading(true);
      final File imageFile = File(pickedFile.path);

      // حفظ في مجلد التطبيق
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');

      // حفظ المسار في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imageKey, savedImage.path);

      imagePath.value = savedImage.path;
      Get.snackbar('Success', 'Image saved successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save image: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // حذف الصورة
  Future<void> removeImage() async {
    try {
      if (imagePath.value.isNotEmpty) {
        final file = File(imagePath.value);
        if (await file.exists()) await file.delete();

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_imageKey);

        imagePath.value = '';
        Get.snackbar('Success', 'Image removed successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove image');
    }
  }
}
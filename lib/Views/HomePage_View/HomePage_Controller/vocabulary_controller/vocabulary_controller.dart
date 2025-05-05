import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../HomePage_Screen/vocabulary/vocabulary_screen.dart';

class VocabularyController extends GetxController {
  final folders = <Map<String, dynamic>>[].obs;
  final CollectionReference foldersCollection =
  FirebaseFirestore.instance.collection('Folders');
  final String defaultImage = 'assets/images/dictionary.png';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFolders();
  }

  Future<void> getFolders() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }
      isLoading(true);
      final snapshot = await foldersCollection
          .where('userId', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .get();

      folders.assignAll(snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'image': defaultImage,
          'userId': doc['userId'],
        };
      }));
    } catch (e) {
      Get.snackbar('Error', 'Failed to load folders: ${e.toString()}');
    }
    finally {
      isLoading(false);
    }
  }

  // Future<void> addFolder(String name) async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) {
  //       Get.snackbar('Error', 'User not authenticated');
  //       return;
  //     }
  //
  //     await foldersCollection.add({
  //       'name': name,
  //       'userId': user.uid,
  //       'created_at': FieldValue.serverTimestamp(),
  //     });
  //     await getFolders();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to add folder: ${e.toString()}');
  //   }
  // }
  Future<void> addFolder(String name) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      await foldersCollection.add({
        'name': name,
        'userId': user.uid,
        'created_at': FieldValue.serverTimestamp(),
      });

      await getFolders();

      // إظهار الإشعار بعد الإضافة الناجحة
      await NotificationHelper.showNotification(
        'تمت الإضافة',
        'تم إضافة المجلد: $name',
      );

    } catch (e) {
      Get.snackbar('Error', 'Failed to add folder: ${e.toString()}');
    }
  }

  Future<void> deleteFolder(String folderId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('خطأ', 'يجب تسجيل الدخول أولاً');
        return;
      }
      await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folderId)
          .delete();

      // 3. تحديث الواجهة
      final controller = Get.find<VocabularyController>();
      controller.folders.removeWhere((folder) => folder['id'] == folderId);
      controller.folders.refresh();

      Get.snackbar('نجاح', 'تم حذف المجلد بنجاح');

    } on FirebaseException catch (e) {
      Get.snackbar('خطأ في القاعدة', e.message ?? 'حدث خطأ غير معروف');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الحذف');
    }
  }

  Future<void> updateFolder(String folderId, String newName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('خطأ', 'يجب تسجيل الدخول أولاً');
        return;
      }

      final trimmedName = newName.trim();
      if (trimmedName.isEmpty) {
        Get.snackbar('خطأ', 'اسم المجلد لا يمكن أن يكون فارغاً');
        return;
      }

      // 3. الفلترة والتحديث الآمن
      await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folderId)
          .update({
        'name': trimmedName,
        'updated_at': FieldValue.serverTimestamp(),

      });

      // 4. تحديث الواجهة
      final controller = Get.find<VocabularyController>();
      final index = controller.folders.indexWhere((f) => f['id'] == folderId);
      if (index != -1) {
        controller.folders[index]['name'] = trimmedName;
        controller.folders.refresh();
      }

      Get.snackbar('نجاح', 'تم تحديث المجلد بنجاح');

    } on FirebaseException catch (e) {
      Get.snackbar('خطأ في القاعدة', e.message ?? 'حدث خطأ غير معروف');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء التحديث');
    }
  }
}
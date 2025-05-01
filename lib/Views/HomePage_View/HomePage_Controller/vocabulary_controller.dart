import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VocabularyController extends GetxController {
  final folders = <Map<String, dynamic>>[].obs;
  final CollectionReference foldersCollection =
  FirebaseFirestore.instance.collection('Folders');
  final String defaultImage = 'assets/images/dictionary.png';

  @override
  void onInit() {
    super.onInit();
    getFolders();
  }

  Future<void> getFolders() async {
    try {
      final snapshot = await foldersCollection.get();
      folders.assignAll(snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'image': defaultImage,
        };
      }));
    } catch (e) {
      Get.snackbar('Error', 'Failed to load folders');
    }
  }

  Future<void> addFolder(String name) async {
    try {
      await foldersCollection.add({
        'name': name,
        'created_at': FieldValue.serverTimestamp(),
      });
      getFolders();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add folder');
    }
  }

  Future<void> deleteFolder(String folderId) async {
    try {
      await foldersCollection.doc(folderId).delete();
      folders.removeWhere((folder) => folder['id'] == folderId);
      Get.snackbar('Success', 'Folder deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete folder');
    }
  }

  Future<void> updateFolder(String folderId, String newName) async {
    try {
      if (newName.trim().isEmpty) {
        Get.snackbar('Error', 'Folder name cannot be empty');
        return;
      }

      await foldersCollection.doc(folderId).update({
        'name': newName,
        'updated_at': FieldValue.serverTimestamp(),
      });


      final index = folders.indexWhere((folder) => folder['id'] == folderId);
      if (index != -1) {
        folders[index]['name'] = newName;
        folders.refresh();
      }

      Get.snackbar('Success', 'Folder updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update folder: ${e.toString()}');
    }
  }
}
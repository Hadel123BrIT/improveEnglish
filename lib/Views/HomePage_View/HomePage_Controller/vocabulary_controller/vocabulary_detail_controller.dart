import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../Models/WordModel.dart';

class VocabularyFolderController extends GetxController {
  final words = <WordModel>[].obs;
  final folderName = ''.obs;
  final isLoading = false.obs;

  // دالة إضافة كلمة جديدة
  Future<void> addWord(
      String folderId,
      String term,
      String meaning, {
        String? example,
      }) async {
    try {
      isLoading(true);

      await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .add({
        'term': term,
        'meaning': meaning,
        'example': example,
        'created_at': FieldValue.serverTimestamp(),
      });

      await loadWords(folderId); // إعادة تحميل الكلمات بعد الإضافة

    } catch (e) {
      Get.snackbar('Error', 'Failed to add word: ${e.toString()}');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // دالة تحميل الكلمات
  Future<void> loadWords(String folderId) async {
    try {
      isLoading(true);
      words.clear();

      final folderDoc = await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folderId)
          .get();

      folderName.value = folderDoc['name'];

      final wordsSnapshot = await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .orderBy('created_at', descending: true)
          .get();

      words.assignAll(wordsSnapshot.docs.map((doc) =>
          WordModel.fromMap(doc.data(), doc.id)));

    } catch (e) {
      Get.snackbar('Error', 'Failed to load words: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
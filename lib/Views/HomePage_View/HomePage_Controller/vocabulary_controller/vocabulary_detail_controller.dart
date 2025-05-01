import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../Models/WordModel.dart';

class VocabularyFolderController extends GetxController {
  final words = <WordModel>[].obs;
  final folderName = ''.obs;
  final isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWord(
      String folderId,
      String term,
      String meaning, {
        String? example,
      }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      isLoading(true);

      await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .add({
        'term': term,
        'meaning': meaning,
        'example': example,
        'userId': user.uid,
        'created_at': FieldValue.serverTimestamp(),
      });

      await loadWords(folderId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add word: ${e.toString()}');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadWords(String folderId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      isLoading(true);
      words.clear();

      // التحقق من ملكية المجلد أولاً
      final folderDoc = await _firestore
          .collection('Folders')
          .doc(folderId)
          .get();

      if (folderDoc.data()?['userId'] != user.uid) {
        Get.snackbar('Error', 'You do not have access to this folder');
        return;
      }

      folderName.value = folderDoc['name'];

      final wordsSnapshot = await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .where('userId', isEqualTo: user.uid)
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

  Future<void> deleteWord(String folderId, String wordId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      isLoading(true);

      final wordDoc = await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .doc(wordId)
          .get();

      if (wordDoc.data()?['userId'] != user.uid) {
        Get.snackbar('Error', 'You do not own this word');
        return;
      }

      await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .doc(wordId)
          .delete();

      words.removeWhere((word) => word.id == wordId);
      Get.snackbar('Success', 'Word deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete word: ${e.toString()}');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateWord(
      String folderId,
      String wordId,
      String newTerm,
      String newMeaning, {
        String? newExample,
      }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      isLoading(true);

      final wordDoc = await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .doc(wordId)
          .get();

      if (wordDoc.data()?['userId'] != user.uid) {
        Get.snackbar('Error', 'You do not own this word');
        return;
      }

      await _firestore
          .collection('Folders')
          .doc(folderId)
          .collection('words')
          .doc(wordId)
          .update({
        'term': newTerm,
        'meaning': newMeaning,
        'example': newExample,
        'updated_at': FieldValue.serverTimestamp(),
      });

      final index = words.indexWhere((word) => word.id == wordId);
      if (index != -1) {
        words[index] = WordModel(
          id: wordId,
          term: newTerm,
          meaning: newMeaning,
          example: newExample,
        );
      }

      Get.snackbar('Success', 'Word updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update word: ${e.toString()}');
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
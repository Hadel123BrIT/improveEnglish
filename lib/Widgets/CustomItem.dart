import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/AppRoutes.dart';
import '../Views/HomePage_View/HomePage_Controller/vocabulary_controller.dart';
import '../Views/HomePage_View/HomePage_Screen/gaming_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/listening_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/reading_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/speaking_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/vocabulary_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/writing_screen.dart';
import 'AwesomeDialog.dart';

class CustomItem extends StatelessWidget {
   CustomItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.color = Colors.white,
      required this.folderId,
  });

  final String? imagePath;
  final String? title;
  final Color? color;
   final String? folderId;
  final RxBool? isPressed = false.obs;

   void _navigateToScreen() {
     switch (title) {
       case 'Vocabulary':
         Get.to(() => VocabularyScreen(),arguments: title);
         break;
       case 'Gaming':
         Get.to(() => GamingScreen(),arguments: title);
         break;
       case 'Reading':
         Get.to(() => ReadingScreen(),arguments: title);
         break;
       case 'Writing':
         Get.to(() => WritingScreen(),arguments: title);
         break;
       case 'Listening':
         Get.to(() => ListeningScreen(),arguments: title);
         break;
       case 'Speaking':
         Get.to(() => SpeakingScreen(),arguments: title);
         break;
       default:
         Get.snackbar('Error', 'Screen not found, just you can update or delete');
     }
   }
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTapDown: (_) => isPressed?.value = true,
        onTapUp: (_) => isPressed?.value = false,
        onTapCancel: () => isPressed?.value = false,
        onTap:_navigateToScreen,
              onLongPress: () {
                final controller = Get.find<VocabularyController>();
                DialogService.show(
                  title: title!,
                  message: "Do you want to edit this folder or delete?",
                  onConfirm: () async {
                    TextEditingController editController = TextEditingController(text: title);
                     await Get.defaultDialog(
                      title: 'Edit Folder',
                      content: TextField(
                        controller: editController,
                        decoration: InputDecoration(
                          labelText: 'New Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      textConfirm: 'Save',
                      textCancel: 'Cancel',
                      onConfirm: () async {
                        Get.back();
                        Get.back();
                        if (editController.text.isNotEmpty) {
                          await controller.updateFolder(folderId!, editController.text);
                          Get.to(VocabularyScreen());
                        }
                      },
                    );
                  },
                  onCancel: () async {
                    print("*************************************yes");

                    // استخدم Future.delayed لإعطاء وقت لإغلاق الـ dialog الحالي
                    await Future.delayed(Duration(milliseconds: 300));

                    final confirm = await Get.defaultDialog<bool>(
                      title: 'Confirm Delete',
                      middleText: 'Are you sure you want to delete "$title"?',
                      textConfirm: 'Delete',
                      textCancel: 'Cancel',
                      confirmTextColor: Colors.white,
                      barrierDismissible: false,
                      onConfirm: () async {
                        print("*************************************no");
                        Get.back(); // إغلاق dialog التأكيد
                        await controller.deleteFolder(folderId!);
                        Get.off(() => VocabularyScreen());
                      },
                      onCancel: () => Get.back(),
                    );

                    if (confirm == true) {
                      Get.back(); // إغلاق dialog الخيارات الرئيسي
                    }
                  },

                );
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isPressed!.value ? Colors.grey[300] : color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
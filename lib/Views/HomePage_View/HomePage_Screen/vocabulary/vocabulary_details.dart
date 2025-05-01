import 'package:app_with_firebase/Core/Constances/all_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../Widgets/buildFooter.dart';
import '../../../../Widgets/getSearch.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_detail_controller.dart';
import 'WordItem .dart';


class VocabularyDetails extends StatelessWidget {
  VocabularyDetails({super.key, required this.folderId});
  final currentTabIndex = 0.obs;
  final String folderId;
  final VocabularyFolderController controller = Get.put(VocabularyFolderController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    controller.loadWords(folderId);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: screenWidth * 0.06,
        ),
        elevation: 0.0,
        backgroundColor: background,
        title: Obx(() => Text(controller.folderName.value)),
      ),
      bottomNavigationBar: BuildFotter(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.add_box_outlined, color: Colors.black),
        onPressed: () => _showAddWordDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Getsearch(),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Lottie.asset(
                    'assets/animations/search.json',
                    fit: BoxFit.contain,
                    repeat: true,
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.4,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                itemCount: controller.words.length,
                itemBuilder: (_, index) => WordItem(controller.words[index]),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddWordDialog(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final termController = TextEditingController();
    final meaningController = TextEditingController();
    final exampleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add New Word',
      titleStyle: TextStyle(fontSize: mediaQuery.size.width * 0.05),
      content: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: termController,
              decoration: InputDecoration(
                labelText: 'Term',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.03,
                  vertical: mediaQuery.size.height * 0.02,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextField(
              controller: meaningController,
              decoration: InputDecoration(
                labelText: 'Meaning',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.03,
                  vertical: mediaQuery.size.height * 0.02,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextField(
              controller: exampleController,
              decoration: InputDecoration(
                labelText: 'Example (Optional)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.03,
                  vertical: mediaQuery.size.height * 0.02,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel', style: TextStyle(fontSize: mediaQuery.size.width * 0.04)),
        ),
        ElevatedButton(
          onPressed: () async {
            if (termController.text.isNotEmpty && meaningController.text.isNotEmpty) {
              Get.back();
              try {
                await controller.addWord(
                  folderId,
                  termController.text,
                  meaningController.text,
                  example: exampleController.text,
                );
              } catch (e) {
                Get.snackbar('Error', 'Failed to add word');
              }
            }
          },
          child: Text('Add', style: TextStyle(fontSize: mediaQuery.size.width * 0.04)),
        ),
      ],
    );
  }
}
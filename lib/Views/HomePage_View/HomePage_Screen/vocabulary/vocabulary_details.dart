import 'package:app_with_firebase/Core/Constances/all_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../../Widgets/buildFooter.dart';
import '../../../../Widgets/getSearch.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_detail_controller.dart';
import 'WordItem .dart';

class VocabularyDetails extends StatelessWidget {
  VocabularyDetails({super.key, required this.folderId});

  final String folderId;
  final VocabularyFolderController controller = Get.put(VocabularyFolderController());

  @override
  Widget build(BuildContext context) {
    controller.loadWords(folderId);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
          centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 25
        ),
        elevation: 0.0,
          backgroundColor: background,
          title: Obx(() => Text(controller.folderName.value),
      )),
      bottomNavigationBar: BuildFotter(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.add_box_outlined, color: Colors.black),
        onPressed: () =>  _showAddWordDialog(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Getsearch(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: Lottie.asset(
                    'assets/animations/search.json',
                    fit: BoxFit.cover,
                    repeat: true,
                    height: 150,
                    width: 150
                ));
              }
              return ListView.builder(
                itemCount: controller.words.length,
                itemBuilder: (_, index) => WordItem(controller.words[index]),
              );
            }),
          ),
        ],
      ),
    );
  }
  void _showAddWordDialog() {
    final termController = TextEditingController();
    final meaningController = TextEditingController();
    final exampleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add New Word',
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: termController,
              decoration: InputDecoration(
                labelText: 'Term',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: meaningController,
              decoration: InputDecoration(
                labelText: 'Meaning',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: exampleController,
              decoration: InputDecoration(
                labelText: 'Example (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
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
          child: Text('Add'),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../Core/Constances/all_colors.dart';
import '../../../../Widgets/BottomSheet.dart';
import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/CustomItem.dart';
import '../../../../Widgets/buildFooter.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';

class VocabularyScreen extends GetView<VocabularyController> {
  VocabularyScreen({super.key});
  final currentTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final VocabularyController _controller = Get.put(VocabularyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppbar(
        ScaffoldKey: scaffoldKey,
        keytool: 90,
        title: '',
        text: "Vocabulary",
        isappear: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add_box_outlined, color: Colors.black),
        onPressed: () => AddVocabularySheet().show(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: background,
      bottomNavigationBar:  BuildFotter(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              "You Can Add any kind of Vocabulary",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: Obx(() {
                if (_controller.folders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "No folders yet",
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          "Tap + button to add new folder",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _controller.folders.length,
                  itemBuilder: (context, index) {
                    final folder = _controller.folders[index];
                    return CustomItem(
                      imagePath: folder['image'],
                      title: folder['name'],
                      folderId: folder['id'],
                      color: Colors.white,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
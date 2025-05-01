import 'package:app_with_firebase/Views/HomePage_View/HomePage_Controller/writing_controller/writing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../Widgets/BottomSheet.dart';
import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/CustomItem.dart';
import '../../../../Widgets/buildFooter.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';

class WritingScreen extends GetView<WritingController> {
  WritingScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // final WritingController _controller = Get.put(WritingController());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppbar(
        ScaffoldKey: scaffoldKey,
        keytool: 90,
        title: '',
        text: "Writing",
        isappear: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.add_box_outlined, color: Colors.black),
        onPressed: () => (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Color.fromARGB(255, 254, 250, 229),
      bottomNavigationBar: BuildFotter(),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text(
              "You Can Add any kind of Writing",
              style: TextStyle(
                  fontSize: mediaQuery.size.width * 0.05,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: Obx(() {
                if (controller.folders.isEmpty) {
                  return Center(child: Text("No folders yet. Tap + to add"));
                }
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: controller.folders.length,
                  itemBuilder: (context, index) {
                    final folder = controller.folders[index];
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
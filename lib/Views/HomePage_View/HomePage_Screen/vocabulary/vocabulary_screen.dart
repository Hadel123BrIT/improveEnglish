import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../Core/Constances/all_colors.dart';
import '../../../../Widgets/BottomSheet.dart';
import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/CustomItem.dart';
import '../../../../Widgets/buildFoot/buildFoot_Controller.dart';
import '../../../../Widgets/buildFoot/buildFooter.dart';
import '../../../../notification_helper.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class VocabularyScreen extends GetView<VocabularyController> {
  VocabularyScreen({super.key});
  final currentTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final VocabularyController _controller = Get.put(VocabularyController());
  final NavigationController navController = Get.put(NavigationController());

  @override
  void initState() {
    NotificationHelper.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppbar(
        ScaffoldKey: scaffoldKey,
        keytool: screenWidth * 0.2,
        title: '',
        text: "Vocabulary",
        isappear: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.add_box_outlined,
            color: Colors.black,
            size: screenWidth * 0.06),
        onPressed: () async {
          final result = await AddVocabularySheet().show(context);
          if (result != null) {
            await NotificationHelper.showNotification(
              'Folder is added: $result',
              'You are a good student , Continue',
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: background,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Text(
              "You Can Add any kind of Vocabulary",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(
                    child: Lottie.asset(
                      'assets/animations/search.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.5,
                    ),
                  );
                }
                else if (_controller.folders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "No folders yet",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                        Text(
                          "Tap + button to add new folder",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.02,
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
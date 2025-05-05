// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import '../../../../Core/Constances/all_colors.dart';
// import '../../../../Widgets/BottomSheet.dart';
// import '../../../../Widgets/CustomAppbar.dart';
// import '../../../../Widgets/CustomItem.dart';
// import '../../../../Widgets/buildFoot/buildFoot_Controller.dart';
// import '../../../../Widgets/buildFoot/buildFooter.dart';
// import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';
// import  'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// class VocabularyScreen extends GetView<VocabularyController> {
//   VocabularyScreen({super.key});
//   final currentTabIndex = 0.obs;
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//   final VocabularyController _controller = Get.put(VocabularyController());
//   final NavigationController navController = Get.put(NavigationController());
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: CustomAppbar(
//         ScaffoldKey: scaffoldKey,
//         keytool: 90,
//         title: '',
//         text: "Vocabulary",
//         isappear: false,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.grey[300],
//         child: const Icon(Icons.add_box_outlined, color: Colors.black),
//         onPressed: () => AddVocabularySheet().show(context),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       backgroundColor: background,
//       bottomNavigationBar: CustomBottomNavigationBar(navController: navController,),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 25),
//             Text(
//               "You Can Add any kind of Vocabulary",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 25),
//             Expanded(
//               child: Obx(() {
//                 if (_controller.folders.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 20),
//                         const Text(
//                           "No folders yet",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         const Text(
//                           "Tap + button to add new folder",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return GridView.builder(
//                   padding: EdgeInsets.zero,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   itemCount: _controller.folders.length,
//                   itemBuilder: (context, index) {
//                     final folder = _controller.folders[index];
//                     return CustomItem(
//                       imagePath: folder['image'],
//                       title: folder['name'],
//                       folderId: folder['id'],
//                       color: Colors.white,
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../Core/Constances/all_colors.dart';
import '../../../../Widgets/BottomSheet.dart';
import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/CustomItem.dart';
import '../../../../Widgets/buildFoot/buildFoot_Controller.dart';
import '../../../../Widgets/buildFoot/buildFooter.dart';
import '../../HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/dictionary.png');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _notifications.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'vocabulary_channel',
      'Vocabulary Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notifications.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

class VocabularyScreen extends GetView<VocabularyController> {
  VocabularyScreen({super.key});
  final currentTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final VocabularyController _controller = Get.put(VocabularyController());
  final NavigationController navController = Get.put(NavigationController());

  @override
  void initState() {

    NotificationHelper.initialize(); // تهيئة الإشعارات عند بدء الصفحة
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
        keytool: 90,
        title: '',
        text: "Vocabulary",
        isappear: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add_box_outlined, color: Colors.black),
        onPressed: () async {
          final result = await AddVocabularySheet().show(context);
          if (result != null) {
            // إظهار الإشعار عند إضافة ملف جديد
            await NotificationHelper.showNotification(
              'تمت إضافة ملف جديد',
              'تمت إضافة الملف: $result',
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: background,
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
                    else if (_controller.folders.isEmpty) {
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
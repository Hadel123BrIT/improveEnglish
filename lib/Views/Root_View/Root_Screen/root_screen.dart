// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/gaming/gaming_screen.dart';
// import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
// import 'package:app_with_firebase/Views/MyProfile_View/MyProfile_Screen/myProfile_screen.dart';
// import 'package:app_with_firebase/Views/Setting_View/Setting_Screen/setting_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Routes/AppRoutes.dart';
// import '../../../Widgets/buildFooter.dart';
// import '../../../core/constances/all_colors.dart';
// import '../../../widgets/BottomBar.dart';
// import '../Root_controller/root_controller.dart';
//
//
// class RootScreen extends GetView<RootController> {
//   const RootScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => RootController());
//     final mediaQuery = MediaQuery.of(context);
//     //حطينا ال obx لانو في عندي زرين وعندي اعادة بناء لكل واحد منهن
//     return Obx(
//           () => Scaffold(
//         // resizeToAvoidBottomInset: false,
//         body: _buildBody(),
//         bottomNavigationBar: BuildFotter(),
//             floatingActionButton: FloatingActionButton(
//               backgroundColor: Colors.grey[300],
//               child: Container(
//                 width: mediaQuery.size.width * 0.06,
//                 height: mediaQuery.size.width * 0.06,
//                 child: Icon(Icons.add_box_outlined, color: Colors.black),
//               ),
//               onPressed: () {
//
//
//               },
//             ),
//             floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     return IndexedStack(
//       index: controller.tabIndex.value,
//       children: [
//        HomepageScreen(),
//         GamingScreen(),
//         MyProfileScreen(),
//         SettingScreen(),
//       ],
//     );
//   }
//
// }

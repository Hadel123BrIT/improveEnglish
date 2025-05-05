import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/HomePage_View/HomePage_Screen/gaming/gaming_screen.dart';
import '../../Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import '../../Views/MyProfile_View/MyProfile_Screen/myProfile_screen.dart';
import '../../Views/Setting_View/Setting_Screen/setting_screen.dart';

// class NavigationController extends GetxController {
//   var tabIndex = 0.obs;
//
//   // قائمة الصفحات
//   final List<Widget> tabs = [
//     HomepageScreen(),
//     GamingScreen(),
//     MyProfileScreen(),
//     SettingScreen(),
//   ];
//
//   // قائمة الأيقونات المقابلة
//   final List<IconData> icons = [
//     Icons.home,
//     Icons.games,
//     Icons.person,
//     Icons.settings,
//   ];
//
//   Widget get currentScreen => tabs[tabIndex.value];
//
//   // void changeIndex(int index) {
//   //
//   //   switch(index){
//   //     case 0 :
//   //       Get.to(()=>HomepageScreen());
//   //     case 1 :
//   //       Get.to(()=>GamingScreen());
//   //     case 2 :
//   //       Get.to(()=>MyProfileScreen());
//   //     case 3 :
//   //       Get.to(()=>SettingScreen());
//   //
//   //   }
//   //}
//   void changeIndex(int index) {
//     tabIndex.value = index;
//   }
// }


class NavigationController extends GetxController {
  var tabIndex = 0.obs;

  final List<IconData> icons = [
    Icons.home,
    Icons.games,
    Icons.person,
    Icons.settings,
  ];

  void changeIndex(int index) {
    if (tabIndex.value != index) {
      tabIndex.value = index;
      _navigateToPage(index);
    }
  }

  void _navigateToPage(int index) {
    switch(index) {
      case 0:
        Get.to(() => HomepageScreen());
        break;
      case 1:
        Get.to(() => GamingScreen());
        break;
      case 2:
        Get.to(() => MyProfileScreen());
        break;
      case 3:
        Get.to(() => SettingScreen());
        break;
    }
  }
}
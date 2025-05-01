import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_with_firebase/Views/Root_View/Root_controller/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Views/HomePage_View/HomePage_Screen/gaming/gaming_screen.dart';
import '../Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import '../Views/MyProfile_View/MyProfile_Screen/myProfile_screen.dart';
import '../Views/Setting_View/Setting_Screen/setting_screen.dart';
import 'BottomBar.dart';

class BuildFotter extends GetView<RootController>{
  RootController controller =Get.put(RootController());
  @override
  Widget build(BuildContext context) {
   return AnimatedBottomNavigationBar.builder(
     onTap: (index) {
       controller.tabIndex.value = index;
     },
     itemCount: controller.tabs.length,
     backgroundColor: Colors.orangeAccent[100],
     gapLocation: GapLocation.center,
     notchSmoothness: NotchSmoothness.verySmoothEdge,
     tabBuilder: (int index, bool isActive) {
       return BottombarItem(
         isActive: isActive,
         icon: Icon(
           controller.tabs[index] as IconData?,
           color: isActive ? Colors.grey: Colors.grey,
         ),
       );
     }, activeIndex: -1,

   );
  }

}
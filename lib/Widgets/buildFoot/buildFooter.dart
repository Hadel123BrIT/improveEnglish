import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../Core/Constances/all_colors.dart';
import '../../Views/HomePage_View/HomePage_Screen/gaming/gaming_screen.dart';
import '../../Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import '../../Views/MyProfile_View/MyProfile_Screen/myProfile_screen.dart';
import '../../Views/Setting_View/Setting_Screen/setting_screen.dart';
import '../BottomBar.dart';
import 'buildFoot_Controller.dart';

// class CustomBottomNavigationBar extends GetView<NavigationController> {
//   const CustomBottomNavigationBar({Key? key, required NavigationController navController}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => AnimatedBottomNavigationBar.builder(
//       onTap: (index) {
//         controller.tabIndex.value = index;
//         controller.changeIndex(index);
//       },
//       itemCount: controller.tabs.length,
//       backgroundColor: Colors.orangeAccent[100],
//       gapLocation: GapLocation.center,
//       notchSmoothness: NotchSmoothness.verySmoothEdge,
//       tabBuilder: (int index, bool isActive) {
//         return BottombarItem(
//           isActive: isActive,
//           icon: Icon(
//             controller.icons[index],
//             color: isActive ? Colors.grey: Colors.grey,
//           ),
//         );
//       },
//       activeIndex: controller.tabIndex.value,
//     ));
//   }
// }


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Obx(() => AnimatedBottomNavigationBar.builder(
      itemCount: controller.icons.length,
      backgroundColor: Colors.orangeAccent[100]!,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              controller.icons[index],
              color: isActive ? Colors.orange : Colors.grey,
              size: 24,
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 18,
                color: Colors.orange,
              ),
          ],
        );
      },
      activeIndex: controller.tabIndex.value,
      onTap: controller.changeIndex,
    ));
  }
}


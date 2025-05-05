import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Views/HomePage_View/HomePage_Controller/homePage_controller.dart';
import '../Views/Register_View/register_controller/register_controller.dart';
import '../Views/Root_View/Root_controller/root_controller.dart';
import '../Widgets/buildFoot/buildFoot_Controller.dart';

class binding implements Bindings {
  @override
  void dependencies() {
     Get.put(NavigationController());


  }
}
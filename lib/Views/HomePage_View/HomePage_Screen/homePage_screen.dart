import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../Widgets/CustomAppbar.dart';
import '../../../Widgets/CustomDrawer.dart';
import '../../../Widgets/Customslivergrid.dart';
import '../../../Widgets/buildFoot/buildFoot_Controller.dart';
import '../../../Widgets/buildFoot/buildFooter.dart';
import '../../Register_View/register_controller/register_controller.dart';
import '../HomePage_Controller/homePage_controller.dart';

class HomepageScreen extends GetView<HomepageController> {
  final RegisterController registerController = Get.put(RegisterController());
  final GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();

  HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[300],
          child: Container(
            width: mediaQuery.size.width * 0.06,
            height: mediaQuery.size.width * 0.06,
            child: Icon(Icons.add_box_outlined, color: Colors.black),
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Color.fromARGB(255, 254, 250, 229),
        key: ScaffoldKey,
        drawer: CustomDrawer(),
        appBar: CustomAppbar(
          ScaffoldKey: ScaffoldKey,
          title: '   Hadel',
          text: 'Welcome',
          isappear: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  "Select a task which would you like",
                  style: TextStyle(
                    fontSize: mediaQuery.size.width * 0.06,
                    color: Colors.black,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              Customslivergrid(),
            ],
          ),
        ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
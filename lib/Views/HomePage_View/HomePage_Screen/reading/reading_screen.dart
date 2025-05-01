import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/buildFooter.dart';

class ReadingScreen extends StatelessWidget {
   ReadingScreen({super.key});
   final currentTabIndex = 0.obs;
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppbar(ScaffoldKey: ScaffoldKey,keytool: 90, title: '', text: "Let's read together", isappear: false,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Container(
          width: mediaQuery.size.width * 0.06,
          height: mediaQuery.size.width * 0.06,
          child: Icon(Icons.add_box_outlined, color: Colors.black),
        ),
        onPressed: () {


        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor:Color.fromARGB(255, 254, 250, 229) ,
      bottomNavigationBar: BuildFotter(),
    );
  }
}

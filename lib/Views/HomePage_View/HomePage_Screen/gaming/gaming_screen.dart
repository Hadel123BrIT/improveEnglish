import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Widgets/CustomAppbar.dart';
import '../../../../Widgets/buildFooter.dart';

class GamingScreen extends StatelessWidget {
   GamingScreen({super.key});
   GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
   final currentTabIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    print("yes");
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppbar(ScaffoldKey: ScaffoldKey,keytool: 90, title: '', text: "Let's game together", isappear: false,),
      backgroundColor:Color.fromARGB(255, 254, 250, 229) ,
      bottomNavigationBar: BuildFotter(),
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
    );
  }
}

import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:app_with_firebase/Views/Login_View/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Models/DrawItemModel.dart';
import 'CustomViewItemList.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key}); // أضف constructor

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}
class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<DrawItemModel> items=[
    DrawItemModel(text: 'HOMEPAGE', icon: Icons.home, function: (){
      Get.to(()=>HomepageScreen());
    }, ),
    DrawItemModel(text: 'SETTING', icon: Icons.settings,function: (){}),
    DrawItemModel(text: 'NOTLFICATIONS', icon: Icons.notifications_active_sharp,function: (){}),
    DrawItemModel(text: 'MYPROFILE', icon: Icons.person,function: (){}),
    DrawItemModel(text: 'LOGOUT', icon: Icons.logout,function: ()async{
  try {
  print("Attempting to logout...");
   GoogleSignIn googleSignIn = GoogleSignIn();
  if (await googleSignIn.isSignedIn()) {
  await googleSignIn.disconnect();
  }
  await FirebaseAuth.instance.signOut();
  print("Successfully logged out!");
  Get.offAll(() => LoginScreen());
  } catch (e) {
  print("Error during logout: $e");
  Get.snackbar('Error', 'Failed to logout: ${e.toString()}');
  }
  }),

  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
    _triggerItemAnimations();
  }

  void _triggerItemAnimations() {
    for (int i = 0; i < items.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          setState(() {
            items[i].animated = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 254, 250, 229),
      elevation: 0,
      child: Column(
        children: [
          ScaleTransition(
            scale: Tween(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.elasticOut,
              ),
            ),
            child: const DrawerHeader(
              child: Icon(
                FontAwesomeIcons.solidHeart,
                size: 56,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomViewItemList(items: items),
        ],
      ),
    );
  }
}
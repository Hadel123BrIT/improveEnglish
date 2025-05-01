import 'dart:async';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:app_with_firebase/Views/Splash_View/Splash_Screen/page1.dart';
import 'package:app_with_firebase/Views/Splash_View/Splash_Screen/page2.dart';
import 'package:app_with_firebase/Views/Splash_View/Splash_Screen/page3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../core/constances/all_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Login_View/login_screen/login_screen.dart';
import '../../Register_View/register_screen/register_screen.dart';
import '../Splash_Controller/splash_controller.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  PageController splashController=PageController();
  bool onlastPage=false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: splashController,
            onPageChanged: (index){
              setState(() {
                onlastPage=(index==2);
              });
            },
            children: [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Text("skip",
                      style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                      splashController.jumpToPage(2);
                    },
                  ),
                  SmoothPageIndicator(
                    controller: splashController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: Colors.orangeAccent,
                      dotColor: Colors.grey,
                    ),
                  ),
                  onlastPage?
                  GestureDetector(
                    onTap: (){
                      ( FirebaseAuth.instance.currentUser!=null &&
                          FirebaseAuth.instance.currentUser!.emailVerified)
                          ?Get.to(HomepageScreen())
                          :Get.to(LoginScreen());

                    },
                    child: Text("done",
                      style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ):
                  GestureDetector(
                    onTap: (){
                      splashController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut );
                    },
                    child: Text("next",
                      style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

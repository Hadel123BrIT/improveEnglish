import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/gaming_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/listening_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/reading_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/speaking_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/vocabulary_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/writing_screen.dart';
import 'package:app_with_firebase/Views/Login_View/login_screen/login_screen.dart';
import 'package:app_with_firebase/Views/Register_View/register_screen/register_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Views/Splash_View/Splash_Screen/splash_screen.dart';
import 'AppRoutes.dart';

class AppPages{
  static final pages=[
    GetPage(
      name: AppRoutes.splash,
      page: ()=> SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: ()=> HomepageScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: ()=> LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: ()=> RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.game,
      page: ()=> GamingScreen(),
    ),
    GetPage(
      name: AppRoutes.listen,
      page: ()=> ListeningScreen(),
    ),
    GetPage(
      name: AppRoutes.write,
      page: ()=> WritingScreen(),
    ),
    GetPage(
      name: AppRoutes.read,
      page: ()=> ReadingScreen(),
    ),
    GetPage(
      name: AppRoutes.speak,
      page: ()=> SpeakingScreen(),
    ),
    GetPage(
      name: AppRoutes.vocabulary,
      page: ()=> VocabularyScreen(),
    ),

  ];
}
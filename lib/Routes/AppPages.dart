import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/gaming/gaming_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/listening/listening_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/reading/reading_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/speaking/speaking_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/vocabulary/vocabulary_screen.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/writing/writing_screen.dart';
import 'package:app_with_firebase/Views/Login_View/login_screen/login_screen.dart';
import 'package:app_with_firebase/Views/Register_View/register_screen/register_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Binding/initalize_binding.dart';
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
      name: AppRoutes.gaming,
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
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:app_with_firebase/Views/Splash_View/Splash_Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Binding/initalize_binding.dart';
import 'Routes/AppPages.dart';
import 'Routes/AppRoutes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
     home: SplashScreen(),
     // home: HomepageScreen(),
    );
  }
}
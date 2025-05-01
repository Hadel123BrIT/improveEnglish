import 'package:app_with_firebase/Routes/AppRoutes.dart';
import 'package:app_with_firebase/Views/HomePage_View/HomePage_Screen/homePage_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Widgets/AwesomeDialog.dart';


class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      print("Validation failed");
      return;
    }

    try {
      isLoading(true);
      print("Registering user...");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      Get.offAll(() => HomepageScreen());
    } on FirebaseAuthException catch (e) {
      handleFirebaseError(context, e);
    } catch (e) {
      print(e);
      DialogService.showErrorDialog(context, desc: 'حدث خطأ غير متوقع');
    } finally {
      isLoading(false);
    }
  }

  void handleFirebaseError(BuildContext context, FirebaseAuthException e) {
    String errorMessage;

    if (e.code == 'weak-password') {
      errorMessage = 'The password is too weak';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'This email is already in use.';
    } else {
      errorMessage = 'حدث خطأ أثناء التسجيل: ${e.message}';
    }

    DialogService.showErrorDialog(context, desc: errorMessage);
  }

}
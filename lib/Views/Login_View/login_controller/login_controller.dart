import 'package:app_with_firebase/Routes/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Widgets/AwesomeDialog.dart';
import '../../HomePage_View/HomePage_Screen/homePage_screen.dart';
import '../../Register_View/register_controller/register_controller.dart';


class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RegisterController registerController=RegisterController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
       Get.offAll(() => HomepageScreen());
    } catch (e) {
      DialogService.showErrorDialog(Get.context!, desc: "Google sign in failed");
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (emailController.text.isEmpty) {
      DialogService.showErrorDialog(context, desc: "please Enter your Email");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      DialogService.showSuccessDialog(
        context,
        desc: "A message has been sent to your email. Please go to your email and reset your password.",
      );
    } catch (e) {
      DialogService.showErrorDialog(
        context,
        desc: "Please make sure that your email address is valid.",
      );
    }
  }

  Future<void> loginWithEmail(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading(true);
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!credential.user!.emailVerified) {
        await credential.user!.sendEmailVerification();
        DialogService.showErrorDialog(
          context,
          desc: "Please check your email for the code.",
        );
        return;
      }
      Get.offAll(() => HomepageScreen());
      Get.snackbar('Welcome',"${registerController.usernameController.text}");
    } on FirebaseAuthException catch (e) {
      handleFirebaseError(context, e);
    } finally {
      isLoading(false);
    }
  }

  void handleFirebaseError(BuildContext context, FirebaseAuthException e) {
    String errorMessage;
    if (e.code == 'user-not-found') {
      errorMessage = "No user found for that email, Please create a new account";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Wrong password provided for that user.";
    } else {
      errorMessage = "An error occurred while logging in: ${e.message}";
    }
    DialogService.showErrorDialog(context, desc: errorMessage);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
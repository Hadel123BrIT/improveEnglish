import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Widgets/CustomTextForm.dart';
import '../../../Widgets/logo.dart';
import '../../Register_View/register_screen/register_screen.dart';
import '../login_controller/login_controller.dart';


class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 254, 250, 229),
      body: Obx(() => _controller.isLoading.value
          ?  Center(child: Lottie.asset(
        'assets/animations/search.json',
        fit: BoxFit.cover,
        repeat: true,
          height: 150,
          width: 150
      ))
          : Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: ListView(
          children: [
            Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  logo(),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.08,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Login To Continue Using The App",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextForm(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email must not be empty";
                      }
                      return null;
                    },
                    mycontroller: _controller.emailController,
                     hinttext: 'Enter Your Email', obscureText: false,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextForm(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Password must not be empty";
                      }
                      return null;
                    },
                    obscureText: true,
                    mycontroller: _controller.passwordController,
                    hinttext: 'Enter Your Password',
                  ),
                  InkWell(
                    onTap: () => _controller.resetPassword(context),
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        bottom: screenHeight * 0.02,
                      ),
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 254, 250, 229),
                      textColor: Colors.black,
                      onPressed: () => _controller.loginWithEmail(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 254, 250, 229),
                      textColor: Colors.white,
                      onPressed: _controller.signInWithGoogle,
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: _controller.signInWithGoogle,
                              child: Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Image.asset(
                              "assets/images/4.png",
                              width: screenWidth * 0.05,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text.rich(
                        TextSpan(children: [
                           TextSpan(text: "Don't have an account ? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          )
                          ),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
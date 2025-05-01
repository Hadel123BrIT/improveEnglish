import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Widgets/CustomTextForm.dart';
import '../../../Widgets/logo.dart';
import '../../HomePage_View/HomePage_Screen/homePage_screen.dart';
import '../../Login_View/login_screen/login_screen.dart';
import '../register_controller/register_controller.dart';


class RegisterScreen extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 254, 250, 229),
      body:
      Obx(() => _controller.isLoading.value
          ?  Center(child: Lottie.asset(
        'assets/animations/search.json',
        fit: BoxFit.cover,
        repeat: true,
        height: 150,
        width: 150
      )):
       Container(
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
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Register To Continue Using The App",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "User name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextForm(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Username must not be empty";
                  }
                  return null;
                },
                mycontroller:  _controller.usernameController,
                hinttext: 'Enter Your name', obscureText: false,
              ),
              SizedBox(height: screenHeight * 0.01),
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
                  if (!val.isEmail) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                 mycontroller:  _controller.emailController,
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
                  if (val.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                obscureText: true,
                mycontroller: _controller.passwordController,
                hinttext: 'Enter Your Password',
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  bottom: screenHeight * 0.02,
                ),
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 15,
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
                        onPressed: ()  => _controller.register(context),
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     "Or",
                    //     style: TextStyle(
                    //       fontSize: screenWidth * 0.05,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: screenHeight * 0.01),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: MaterialButton(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     color: const Color.fromARGB(255, 254, 250, 229),
                    //     textColor: Colors.white,
                    //     onPressed: _controller.signInWithGoogle,
                    //     child: SizedBox(
                    //       width: screenWidth * 0.5,
                    //       child: Row(
                    //         children: [
                    //           TextButton(
                    //             onPressed: _controller.signInWithGoogle,
                    //             child: Text(
                    //               "Login with Google",
                    //               style: TextStyle(
                    //                   fontSize: screenWidth * 0.04,
                    //                   color: Colors.black
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: screenWidth * 0.03),
                    //           Image.asset(
                    //             "assets/images/4.png",
                    //             width: screenWidth * 0.05,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                           Get.to(() => LoginScreen());
                        },
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "If you  have an account ? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                )
                            ),
                            TextSpan(
                              text: "login",
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
      )
    ));
  }
}
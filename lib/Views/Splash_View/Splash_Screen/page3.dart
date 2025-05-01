import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 250, 229),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Don't worry",
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Text(" I will help you, Let's start",
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Lottie.asset(
              'assets/animations/page3.json',
              fit: BoxFit.cover,
              repeat: true,
            ),

          ],
        ),
      ),
    );
  }
}

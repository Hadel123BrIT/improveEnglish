import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 250, 229),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome",
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Text("You have alot of information in English",
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.06,
                  color: Colors.grey[700]
              ),
            ),
            Text("but can't memorize it?",
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.06,
                color: Colors.grey[700]
              ),
            ),
            Lottie.asset(
              'assets/animations/page1.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ],
        ),
      ),
    );
  }
}

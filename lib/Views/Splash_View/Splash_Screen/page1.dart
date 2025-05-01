import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 250, 229),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              "You have alot of information in English",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            Text(
              "but can't memorize it?",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              child: Lottie.asset(
                'assets/animations/page1.json',
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 250, 229),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't worry",
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "I will help you, Let's start",
              style: TextStyle(
                fontSize: 20, // حجم ثابت
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              child: Lottie.asset(
                'assets/animations/page3.json',
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
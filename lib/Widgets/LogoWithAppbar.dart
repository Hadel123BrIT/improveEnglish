import 'package:flutter/cupertino.dart';

class Logowithappbar extends StatelessWidget {
  const Logowithappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.asset(
          "assets/images/d11cc2d86706427ab5d5f1046cefffdf.png",
          height: 120,
        ),
      ),
    );
  }
}

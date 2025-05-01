import 'package:flutter/material.dart';

class BottombarItem extends StatelessWidget {
  final bool isActive;
  final Widget icon;

  const BottombarItem({
    Key? key,
    required this.isActive,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        if (isActive)
          Container(
            margin: EdgeInsets.only(top: 4),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
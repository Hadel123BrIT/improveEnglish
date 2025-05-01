import 'package:flutter/material.dart';
import '../Models/DrawItemModel.dart';
import 'Customdraweritem.dart';

class CustomViewItemList extends StatelessWidget {
  const CustomViewItemList({super.key, required this.items});
  final List<DrawItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutQuad,
          transform: Matrix4.translationValues(
            0,
            items[index].animated ? 0 : 100,
            0,
          ),
          child: Opacity(
            opacity: items[index].animated ? 1 : 0,
           // duration: Duration(milliseconds: 500 + (index * 100)),
            child: Customdraweritem(customdrawermodel: items[index]),
          ),
        );
      },
    );
  }
}
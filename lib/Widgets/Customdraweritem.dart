import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/DrawItemModel.dart';


class Customdraweritem extends StatelessWidget {
  const Customdraweritem({super.key, required this.customdrawermodel});
  final DrawItemModel   customdrawermodel ;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(customdrawermodel.icon),
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(customdrawermodel.text)),
      ),
    onTap: () {
      print("Tapped on ${customdrawermodel.text}");
      customdrawermodel.function?.call();
    }
    //item.function?.call();
    );
  }
}

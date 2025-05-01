import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomItem.dart';


class Customslivergrid extends StatelessWidget {
   Customslivergrid({super.key});
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/dictionary.png',
      'title': 'Vocabulary',
    },
    {
      'image': 'assets/images/content-writing.png',
      'title': 'Writing',
    },
    {
      'image': 'assets/images/chat.png',
      'title': 'Speaking',
    },
    {
      'image': 'assets/images/active-listening.png',
      'title': 'Listening',
    },

    {
      'image': 'assets/images/united-kingdom.png',
      'title': 'Idioms',
    },
    {
      'image': 'assets/images/open-book.png',
      'title': 'Reading',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 0.9,
    ),
      itemCount: items.length,
      itemBuilder: (context,index){
        return CustomItem(
          imagePath: items[index]['image'],
          title: items[index]['title'],
          color: Colors.white,
          folderId: items[index]['id'],
        );
      },
    );
  }
}

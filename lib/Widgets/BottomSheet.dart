import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Views/HomePage_View/HomePage_Controller/vocabulary_controller/vocabulary_controller.dart';

class AddVocabularySheet {
  final TextEditingController nameController = TextEditingController();
  final VocabularyController controller = Get.put(VocabularyController());

  show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Folder Name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty) {
                    await controller.addFolder(nameController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text('Create Folder'),
              ),
            ],
          ),
        );
      },
    );
  }

}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DialogService {
  static void showErrorDialog(BuildContext context, {required String desc}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: "Error",
      desc: desc,
    ).show();
  }
  static void showSuccessDialog(BuildContext context, {required String desc}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: "Success",
      desc: desc,
    ).show();
  }
  static void show({
  required String title,
  required String message,
  required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
  Get.defaultDialog(
  title: title,
  middleText: message,
  textConfirm: "update",
  textCancel: "delete",
  confirmTextColor: Colors.white,
  onConfirm: onConfirm,
   onCancel: onCancel
  );
  }
}
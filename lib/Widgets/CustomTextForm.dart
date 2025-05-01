import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key, required this.mycontroller, required this.hinttext, required this.validator, required bool obscureText});
  final TextEditingController mycontroller;
  final String hinttext;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[500],
        ),
        filled: true,
        fillColor: Colors.grey[200],
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide(color: Colors.grey),),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
      ),
    );
  }
}

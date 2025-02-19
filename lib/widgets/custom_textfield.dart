import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextfield(
      {super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        contentPadding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
      ),
    );
  }
}

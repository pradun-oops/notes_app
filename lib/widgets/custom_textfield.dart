import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
      ),
    );
  }
}

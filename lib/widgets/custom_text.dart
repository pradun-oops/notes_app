import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomText(
      {super.key,
      required this.text,
      this.size = 15,
      this.textColor = Colors.white,
      this.fontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: textColor,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}

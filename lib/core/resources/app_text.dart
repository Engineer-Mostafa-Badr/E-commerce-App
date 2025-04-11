import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    required this.color,
    this.fontWeight,
    this.textAlign,
    this.decoration,
  });

  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      textAlign: textAlign,
    );
  }
}

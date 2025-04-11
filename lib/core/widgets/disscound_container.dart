import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_text.dart';

class DiscoundContainer extends StatelessWidget {
  const DiscoundContainer({
    super.key,
    this.height,
    this.width,
    required this.color,
    required this.text,
  });

  final double? height;
  final double? width;
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      child: AppText(color: AppColors.kWhiteColor, text: text),
    );
  }
}

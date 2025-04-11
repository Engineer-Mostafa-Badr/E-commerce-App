import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class CustomEBtn extends StatelessWidget {
  const CustomEBtn({
    super.key,
    required this.onPressed,
    required this.hintText,
  });
  final void Function() onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        hintText,
        style: TextStyle(
          color: AppColors.kWhiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

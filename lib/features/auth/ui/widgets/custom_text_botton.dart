import 'package:ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextBotton extends StatelessWidget {
  const CustomTextBotton({
    super.key,
    this.onTap,
    required this.text,
    this.color,
  });

  final void Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: color ?? AppColors.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

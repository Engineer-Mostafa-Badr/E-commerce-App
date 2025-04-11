import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_text.dart';
import 'package:flutter/material.dart';

class CardProfileName extends StatelessWidget {
  const CardProfileName({
    super.key,
    required this.text,
    this.onTap,
    required this.icon,
  });

  final String text;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        color: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: AppColors.kWhiteColor),
                AppText(
                  text: text,
                  color: AppColors.kWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
                Icon(Icons.arrow_forward_ios, color: AppColors.kWhiteColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

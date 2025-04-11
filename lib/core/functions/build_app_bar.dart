import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_text.dart';

AppBar buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhiteColor),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: AppText(
      text: title,
      color: AppColors.kWhiteColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
    backgroundColor: AppColors.kPrimaryColor,
  );
}

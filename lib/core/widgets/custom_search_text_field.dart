import 'package:ecommerce_app/core/resources/app_colors.dart';
import 'package:ecommerce_app/core/resources/constans.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, this.onPressed, this.controller});

  final void Function()? onPressed;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: Constans.searchLabelText,
        hintText: Constans.searchHintText,
        suffixIcon: ElevatedButton.icon(
          onPressed: onPressed,
          label: Icon(Icons.search, color: AppColors.kWhiteColor),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

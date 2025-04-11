import 'package:ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.suffIcon,
    this.isObscure = false,
    required this.kayboardTybe,
    this.controller,
    this.validator,
    this.hintText,
  });

  final String labelText;
  final String? hintText;
  final Widget? suffIcon;
  final bool isObscure;
  final TextInputType kayboardTybe;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      keyboardType: kayboardTybe,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffIcon,
        hintText: hintText,
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

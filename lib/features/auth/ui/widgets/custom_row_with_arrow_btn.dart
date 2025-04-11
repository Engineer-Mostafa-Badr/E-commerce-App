import 'package:ecommerce_app/features/auth/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class CustomRowWithArrowBtn extends StatelessWidget {
  const CustomRowWithArrowBtn({
    super.key,
    required this.hintText,
    required this.onPressed,
  });

  final String hintText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          hintText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        CustomElevatedButton(onPressed: onPressed),
      ],
    );
  }
}

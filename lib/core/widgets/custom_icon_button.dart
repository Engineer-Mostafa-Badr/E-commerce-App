import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });
  final void Function()? onPressed;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(color: color, onPressed: onPressed, icon: Icon(icon));
  }
}

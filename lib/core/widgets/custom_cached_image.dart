import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.child,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      imageUrl: imageUrl,

      placeholder: (context, url) => SizedBox(height: 300, child: child),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

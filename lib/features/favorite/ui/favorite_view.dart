import 'package:ecommerce_app/core/resources/constans.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/widgets/porduct_list.dart';
import '../../../core/resources/app_text.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          AppText(
            text: Constans.favoriteProductsText,
            textAlign: TextAlign.center,
            color: AppColors.kBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          ProductList(isFavoriteView: true),
        ],
      ),
    );
  }
}

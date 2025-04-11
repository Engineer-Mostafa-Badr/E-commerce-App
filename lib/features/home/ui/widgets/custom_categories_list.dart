import 'package:ecommerce_app/features/home/ui/views/category_view.dart';
import 'package:ecommerce_app/core/functions/navigate_to.dart';
import '../../../../core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCategoriesList extends StatelessWidget {
  const CustomCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                navigateTo(
                  context,
                  CategoryView(category: categories[index].text),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.kPrimaryColor,
                    foregroundColor: AppColors.kWhiteColor,
                    child: Icon(categories[index].icon, size: 40),
                  ),
                  Text(categories[index].text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List categories = [
  Category(icon: Icons.sports_basketball, text: 'Sports'),
  Category(icon: Icons.tv, text: 'Electronics'),
  Category(icon: Icons.collections, text: 'Collections'),
  Category(icon: Icons.book, text: 'Books'),
  Category(icon: Icons.games, text: 'Games'),
  Category(icon: Icons.business, text: 'business'),
];

class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}

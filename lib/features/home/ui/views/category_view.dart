import 'package:ecommerce_app/core/functions/build_app_bar.dart';
import '../../../../core/widgets/porduct_list.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, category),
      body: ListView(
        children: [SizedBox(height: 15), ProductList(category: category)],
      ),
    );
  }
}

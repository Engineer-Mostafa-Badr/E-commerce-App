import 'package:ecommerce_app/core/functions/build_app_bar.dart';
import '../../../../core/widgets/porduct_list.dart';
import '../../../../core/resources/constans.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, Constans.searchResultText),
      body: ListView(
        children: [SizedBox(height: 15), ProductList(query: query)],
      ),
    );
  }
}

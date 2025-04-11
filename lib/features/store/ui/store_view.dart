import 'package:ecommerce_app/core/resources/app_colors.dart';
import '../../../core/widgets/custom_search_text_field.dart';
import 'package:ecommerce_app/core/resources/constans.dart';
import 'package:ecommerce_app/core/resources/app_text.dart';
import '../../../core/widgets/custom_message_handler.dart';
import '../../../core/resources/message_type.dart';
import '../../../core/functions/navigate_to.dart';
import '../../../core/widgets/porduct_list.dart';
import '../../home/ui/views/search_view.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          AppText(
            text: Constans.appBarName,
            textAlign: TextAlign.center,
            color: AppColors.kGreyColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 15),

          CustomSearchTextField(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                navigateTo(context, SearchView(query: _searchController.text));
                _searchController.clear();
              } else {
                CustomMessageHandler.showSnackBar(
                  context: context,
                  message: Constans.searchText,
                  type: MessageType.error,
                );
              }
            },
          ),
          const SizedBox(height: 20),
          ProductList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

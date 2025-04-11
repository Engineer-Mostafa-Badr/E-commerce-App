import 'package:ecommerce_app/core/resources/constans.dart';
import '../../../../core/functions/build_app_bar.dart';
import '../../../../core/widgets/porduct_list.dart';
import 'package:flutter/material.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, Constans.myOrdersText),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductList(
          isMyOrderView: true,
          shrinkWrap: false,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

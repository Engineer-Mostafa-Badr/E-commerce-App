import 'package:ecommerce_app/features/profile/ui/widgets/user_comment.dart';
import '../../../../core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from("comments_table")
          .stream(primaryKey: ["id"])
          .eq("for_product", product.productId!)
          .order("created_at"),
      builder: (_, snapshot) {
        List<Map<String, dynamic>>? comments = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder:
                (context, index) => UserComment(commentData: comments?[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: comments?.length ?? 0,
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No Comments Yet'));
        } else {
          return const Center(
            child: Text('Something went wrong , please try again'),
          );
        }
      },
    );
  }
}

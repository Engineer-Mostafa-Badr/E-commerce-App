import 'package:ecommerce_app/core/widgets/imports_widgets.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrderView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;
  final bool isMyOrderView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit()..getProduct(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetDataLoading) {
            CustomCircularIndicator.showLoading();
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Loading..., please wait',
              type: MessageType.info,
            );
          } else {
            CustomCircularIndicator.dismissLoading();
          }
          if (state is BuyProductSuccess) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Payment Success, please check orders',
              type: MessageType.success,
            );
          } else if (state is BuyProductFailure) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Payment Failed, please try again',
              type: MessageType.error,
            );
          } else if (state is GetDataFailure) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Something went wrong, please try again',
              type: MessageType.error,
            );
          } else if (state is AddToFavoriteSuccess) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Product Added to Favorite Successfully',
              type: MessageType.success,
            );
          } else if (state is RemoveFromFavoriteSuccess) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Product Removed from Favorite Successfully',
              type: MessageType.success,
            );
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();
          List<ProductModel> products =
              query != null
                  ? context.read<HomeCubit>().searchResults
                  : category != null
                  ? context.read<HomeCubit>().categoryProducts
                  : isFavoriteView
                  ? homeCubit.favoriteProductsList
                  : isMyOrderView
                  ? homeCubit.userOrders
                  : context.read<HomeCubit>().products;
          return ListView.builder(
            shrinkWrap: shrinkWrap ?? true,
            physics: physics ?? NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                onPaymentSuccess: () async {
                  await homeCubit.buyProduct(
                    productId: products[index].productId!,
                  );
                },
                isFavorite: homeCubit.checkIsFavorite(
                  products[index].productId!,
                ),
                onPressed: () {
                  bool isFavorite = homeCubit.checkIsFavorite(
                    products[index].productId!,
                  );
                  isFavorite
                      ? homeCubit.removeFromFavorite(products[index].productId!)
                      : homeCubit.addToFavorite(products[index].productId!);
                },
                product: products[index],
              );
            },
          );
        },
      ),
    );
  }
}

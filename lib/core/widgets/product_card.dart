import 'package:ecommerce_app/core/widgets/imports_widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onPressed,
    required this.isFavorite,
    required this.onPaymentSuccess,
  });

  final ProductModel product;
  final Function()? onPressed;
  final VoidCallback onPaymentSuccess;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsView(product: product));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        color: AppColors.kWhiteColor,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),

                  child: CustomCachedImage(
                    imageUrl: product.imageUrl ?? AppImages.homeImageNetwork,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  child: DiscoundContainer(
                    height: 35,
                    width: 65,
                    color: AppColors.kPrimaryColor,
                    text: '${product.sale} ${Constans.offText}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: product.productName ?? Constans.productNameText,
                        color: AppColors.kBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      CustomIconButton(
                        icon:
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite
                                ? AppColors.kRedColor
                                : AppColors.kGreyColor,
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AppText(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            text: '${product.price} ${Constans.leText}',
                            color: AppColors.kBlackColor,
                          ),
                          AppText(
                            text: '${product.oldPrice}  ${Constans.leText}',
                            color: AppColors.kGreyColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ],
                      ),
                      CustomEBtn(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PaymentView(
                                    onPaymentSuccess: onPaymentSuccess,
                                    onPaymentError: () {},
                                    price: double.parse(product.price!),
                                  ),
                            ),
                          );
                        },
                        hintText: Constans.buyHintText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

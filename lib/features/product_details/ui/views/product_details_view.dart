import 'package:ecommerce_app/features/product_details/ui/views/imports_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductDetailsCubit()
                ..getRate(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is GetRateLoading ||
              state is AddOrUpdateRateLoading ||
              state is AddCommentLoading) {
            CustomCircularIndicator.showLoading();
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Loading..., please wait',
              type: MessageType.info,
            );
          } else {
            CustomCircularIndicator.dismissLoading();
          }
          if (state is AddOrUpdateRateSuccess) {
            navigateReplacement(context, widget);
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Rate added successfully',
              type: MessageType.success,
            );
          }
          if (state is AddCommentSuccess) {
            navigateReplacement(context, widget);
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Comment added successfully',
              type: MessageType.success,
            );
          } else if (state is AddCommentError ||
              state is GetRateError ||
              state is AddOrUpdateRateError) {
            CustomMessageHandler.showSnackBar(
              context: context,
              message: 'Something went wrong, please try again',
              type: MessageType.error,
            );
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(
              context,
              widget.product.productName ?? Constans.productDetailsText,
            ),
            body: ListView(
              children: [
                CustomCachedImage(
                  imageUrl:
                      widget.product.imageUrl ?? AppImages.homeImageNetwork,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text:
                                widget.product.productName ??
                                Constans.productNameText,
                            color: AppColors.kBlackColor,
                          ),
                          AppText(
                            text: '${widget.product.price} ${Constans.leText}',
                            color: AppColors.kBlackColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('${cubit.averageRate}'),
                              Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                          Icon(Icons.favorite, color: AppColors.kGreyColor),
                        ],
                      ),
                      SizedBox(height: 15),
                      AppText(
                        text:
                            widget.product.discripetion ??
                            Constans.descriptionText,
                        color: AppColors.kBlackColor,
                        fontSize: 20,
                      ),
                      SizedBox(height: 20),
                      RatingBar.builder(
                        initialRating: cubit.userRate.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder:
                            (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          cubit.addOrUpdateRate(
                            productId: widget.product.productId!,
                            data: {
                              'rate': rating.toInt(),
                              'for_user': cubit.userId,
                              'for_product': widget.product.productId!,
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: Constans.commentLabelText,
                        hintText: Constans.commentHintText,
                        controller: _commentController,
                        kayboardTybe: TextInputType.text,
                        suffIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            await context
                                .read<AuthenticationCubit>()
                                .getUserData();
                            await cubit.addComment(
                              data: {
                                'comment': _commentController.text,
                                'for_user': cubit.userId,
                                'for_product': widget.product.productId!,
                                'user_name':
                                    context
                                        .read<AuthenticationCubit>()
                                        .userDataModel
                                        ?.name ??
                                    Constans.userNameText,
                              },
                            );
                            _commentController.clear();
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          AppText(
                            text: Constans.commentsText,
                            color: AppColors.kBlackColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      CommentsListView(product: widget.product),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

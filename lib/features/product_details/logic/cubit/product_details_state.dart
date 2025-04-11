part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetRateLoading extends ProductDetailsState {}

final class GetRateSuccess extends ProductDetailsState {}

final class GetRateError extends ProductDetailsState {
  final String errorMessage;

  GetRateError(this.errorMessage);
}

final class AddOrUpdateRateLoading extends ProductDetailsState {}

final class AddOrUpdateRateSuccess extends ProductDetailsState {}

final class AddOrUpdateRateError extends ProductDetailsState {
  final String errorMessage;

  AddOrUpdateRateError(this.errorMessage);
}

final class AddCommentLoading extends ProductDetailsState {}

final class AddCommentSuccess extends ProductDetailsState {}

final class AddCommentError extends ProductDetailsState {
  final String errorMessage;

  AddCommentError(this.errorMessage);
}

part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {}

final class GetDataFailure extends HomeState {
  final String errorMessage;

  GetDataFailure(this.errorMessage);
}

final class AddToFavoriteLoading extends HomeState {}

final class AddToFavoriteSuccess extends HomeState {}

final class AddToFavoriteFailure extends HomeState {
  final String errorMessage;

  AddToFavoriteFailure(this.errorMessage);
}

final class RemoveFromFavoriteLoading extends HomeState {}

final class RemoveFromFavoriteSuccess extends HomeState {}

final class RemoveFromFavoriteFailure extends HomeState {
  final String errorMessage;

  RemoveFromFavoriteFailure(this.errorMessage);
}

final class GetFavoriteLoading extends HomeState {}

final class GetFavoriteSuccess extends HomeState {}

final class GetFavoriteFailure extends HomeState {
  final String errorMessage;

  GetFavoriteFailure(this.errorMessage);
}

final class BuyProductLoading extends HomeState {}

final class BuyProductSuccess extends HomeState {}

final class BuyProductFailure extends HomeState {
  final String errorMessage;

  BuyProductFailure(this.errorMessage);
}

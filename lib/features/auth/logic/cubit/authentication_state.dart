part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationCubitInitial extends AuthenticationState {}

final class LoginSuccess extends AuthenticationState {}

final class LoginLoading extends AuthenticationState {}

final class LoginError extends AuthenticationState {
  final String errorMessage;

  LoginError(this.errorMessage);
}

final class SignUpSuccess extends AuthenticationState {}

final class SignUpLoading extends AuthenticationState {}

final class SignUpError extends AuthenticationState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}

final class GoogleSignInSuccess extends AuthenticationState {}

final class GoogleSignInLoading extends AuthenticationState {}

final class GoogleSignInError extends AuthenticationState {
  final String errorMessage;

  GoogleSignInError(this.errorMessage);
}

final class LogOutLoading extends AuthenticationState {}

final class LogOutSuccess extends AuthenticationState {}

final class LogOutError extends AuthenticationState {
  final String errorMessage;

  LogOutError(this.errorMessage);
}

final class ResetPasswordLoading extends AuthenticationState {}

final class ResetPasswordSuccess extends AuthenticationState {}

final class ResetPasswordError extends AuthenticationState {
  final String errorMessage;

  ResetPasswordError(this.errorMessage);
}

final class UserDataAddedLoading extends AuthenticationState {}

final class UserDataAddedSuccess extends AuthenticationState {}

final class UserDataAddedError extends AuthenticationState {
  final String errorMessage;

  UserDataAddedError(this.errorMessage);
}

final class GetUserDataLoading extends AuthenticationState {}

final class GetUserDataSuccess extends AuthenticationState {}

final class GetUserDataError extends AuthenticationState {
  final String errorMessage;

  GetUserDataError(this.errorMessage);
}

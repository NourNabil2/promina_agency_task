part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final Auth auth;

  LoginSuccess(this.auth);
}

class LoginError extends LoginState {
  final String? messageErorr;
  LoginError(this.messageErorr);
}



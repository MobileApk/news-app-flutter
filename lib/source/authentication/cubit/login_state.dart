part of 'login_cubit.dart';

class LoginState {
  final String? emailText;
  final String? passwordText;
  final Status? status;
  final String? errorMessage;

  LoginState({
    this.emailText,
    this.passwordText,
    this.status,
    this.errorMessage,
  });

  LoginState copyWith({
    final String? emailText,
    final String? passwordText,
    final String? errorMessage,
    final Status? status,
  }) {
    return LoginState(
      emailText: emailText ?? this.emailText,
      passwordText: passwordText ?? this.passwordText,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum Status {
  loading,
  loaded,
  error,
}

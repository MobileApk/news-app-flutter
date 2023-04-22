import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/services/firebase_service/auth_service.dart';
import 'package:news_app_flutter/services/firebase_service/firebase_auth_service.dart';
import 'package:news_app_flutter/services/local_storage.dart';
import 'package:news_app_flutter/source/authentication/view/login_view.dart';
import 'package:news_app_flutter/source/news/view/home_view.dart';
import 'package:news_app_flutter/source/utils/app_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

  final AppLocalStorage appLocalStorage = AppLocalStorage();

  void updateEmailText(String value) {
    emit(state.copyWith(emailText: value));
  }

  void updatePasswordText(String value) {
    emit(state.copyWith(passwordText: value));
  }

  void clearTextFields() {
    emit(state.copyWith(passwordText: "", emailText: ""));
  }

  validateUser(context) {
    emit(state.copyWith(status: Status.loading));
    if (state.passwordText != null && state.emailText != null) {
      if (state.passwordText!.isEmpty || state.emailText!.isEmpty) {
        AppHelper().showErrorSnackbar(context, "Credentials can't be empty");
        emit(state.copyWith(status: Status.error));
        emit(state.copyWith(status: Status.loaded));
        return false;
      } else if (!state.emailText.isValidEmail()) {
        emit(state.copyWith(status: Status.error));
        emit(state.copyWith(status: Status.loaded));
        AppHelper().showErrorSnackbar(context, "Invalid Email");
        return false;
      } else if ((state.passwordText ?? "").length < 6) {
        emit(state.copyWith(status: Status.error));
        emit(state.copyWith(status: Status.loaded));
        AppHelper().showErrorSnackbar(
            context, "Password must be of atleast 6 characters");
        return false;
      } else {
        return true;
      }
    } else {
      AppHelper().showErrorSnackbar(context, "Credentials can't be empty");
      emit(state.copyWith(status: Status.error));
      emit(state.copyWith(status: Status.loaded));
      return false;
    }
  }

  loginUser(context) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: state.emailText!,
        password: state.passwordText!,
      );
      appLocalStorage.saveLoginState(true);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeView()),
        (Route<dynamic> route) => false,
      );
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      AppHelper().showErrorSnackbar(context, "$e");
      emit(state.copyWith(errorMessage: "$e", status: Status.error));
      emit(state.copyWith(status: Status.loaded));
    }
  }

  signupUser(context) async {
    try {
      await _authService.createUserWithEmailAndPassword(
        email: state.emailText!,
        password: state.passwordText!,
      );
      appLocalStorage.saveLoginState(true);
      emit(state.copyWith(status: Status.loaded));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
        (Route<dynamic> route) => false,
      );
      AppHelper().showSuccessSnackbar(context, "Account Created Successfully");
    } catch (e) {
      AppHelper().showErrorSnackbar(context, "$e");
      emit(state.copyWith(errorMessage: "$e", status: Status.error));
      emit(state.copyWith(status: Status.loaded));
    }
  }

  logoutUser(context) async {
    await FirebaseAuth.instance.signOut();
    appLocalStorage.deleteSharedPrefrence();
    AppHelper().showSuccessSnackbar(context, "User logged out");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}

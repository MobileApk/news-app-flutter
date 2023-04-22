import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/services/local_storage.dart';
import 'package:news_app_flutter/source/authentication/view/login_view.dart';
import 'package:news_app_flutter/source/news/cubit/news_cubit.dart';
import 'package:news_app_flutter/source/news/view/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Duration splashDuration = const Duration(seconds: 2);

    verifyLoginStatus() async {
      bool? loginStatus = await AppLocalStorage().getLoginState();
      log(loginStatus.toString(), name: "LOGIN STATUS");
      if (loginStatus == true) {
        Timer(
          splashDuration,
          () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => NewsCubit()..getNewsResponse(),
                child: const HomeView(),
              ),
            ),
            (Route<dynamic> route) => false,
          ),
        );
      } else {
        Timer(
          splashDuration,
          () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (Route<dynamic> route) => false,
          ),
        );
      }
    }

    verifyLoginStatus();

    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to News App...",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

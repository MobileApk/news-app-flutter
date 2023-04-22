import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/source/authentication/cubit/login_cubit.dart';
import 'package:news_app_flutter/source/authentication/view/sign_up_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var loginCubit = context.read<LoginCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    onChanged: (value) {
                      loginCubit.updateEmailText(value);
                    }),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  onChanged: (value) {
                    loginCubit.updatePasswordText(value);
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      bool isUserValidated =
                          await loginCubit.validateUser(context);
                      if (isUserValidated) {
                        // ignore: use_build_context_synchronously
                        await loginCubit.loginUser(context);
                      }
                    },
                    child: const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
                child: const Text('Create Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/source/authentication/cubit/login_cubit.dart';
import 'package:news_app_flutter/source/utils/app_helper.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    var loginCubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                },
              ),
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
                    bool isValidated = loginCubit.validateUser(context);
                    if (isValidated) {
                      loginCubit.signupUser(context);
                    }
                  },
                  child: const Text('Create Account'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

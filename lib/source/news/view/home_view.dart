import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/source/authentication/cubit/login_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home View"),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: () {
              context.read<LoginCubit>().logoutUser(context);
            },
            icon: Row(
              children: const [
                // Text("Logout"),
                Icon(
                  Icons.logout,
                ),
                // SizedBox(
                //   width: 30,
                // )
              ],
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Home View"),
      ),
    );
  }
}

import 'package:aplikasi_timbang/components/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserInitial) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(LogoutEvent());
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

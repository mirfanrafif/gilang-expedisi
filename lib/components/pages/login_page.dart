import 'package:aplikasi_timbang/components/pages/assigned_job_list_page.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;

  void login() {
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'Username harus diisi';
      });
      return;
    } else {
      setState(() {
        _usernameError = null;
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password harus diisi';
      });
      return;
    } else {
      setState(() {
        _passwordError = null;
      });
    }
    context.read<UserBloc>().add(LoginEvent(
        email: _usernameController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              showErrorSnackbar(context, state.message);
            }
            if (state is LoggedInState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssignedJobListPage(),
                ),
                (route) => false,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(33),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo.png', width: 168),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.people),
                      filled: true,
                      errorText: _usernameError,
                      fillColor: Colors.black12,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Username",
                    ),
                    controller: _usernameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      filled: true,
                      errorText: _passwordError,
                      fillColor: Colors.black12,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Password",
                    ),
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: login,
                      child: const Text("Login"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

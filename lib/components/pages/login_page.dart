import 'package:aplikasi_timbang/components/pages/menu_page.dart';
import 'package:flutter/material.dart';

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

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(33),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo.png', width: 168),
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
    );
  }
}
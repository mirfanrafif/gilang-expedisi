import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang_detail/timbang_detail_bloc.dart';
import 'package:aplikasi_timbang/components/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/timbang/timbang_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimbangBloc>(
          create: (context) => TimbangBloc()..add(LoadTimbangEvent()),
        ),
        BlocProvider(
          create: (context) => SoBloc(),
        ),
        BlocProvider(
          create: (context) => TimbangDetailBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Armada Gilang',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.indigo,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

MaterialColor getAppColor(Color color) {
  return MaterialColor(color.value, {
    50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
    100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
    200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
    300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
    400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
    500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
    600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
    700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
    800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
  });
}

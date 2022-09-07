import 'package:aplikasi_timbang/bloc/detail_timbang/detail_timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/user/user_bloc.dart';
import 'package:aplikasi_timbang/pages/assigned_job_list_page.dart';
import 'package:aplikasi_timbang/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/list_so/list_so_bloc.dart';
import 'data/preferences/base_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BasePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTimbangBloc>(
          create: (context) => DetailTimbangBloc(),
        ),
        BlocProvider<TimbangBloc>(
          create: (context) => TimbangBloc(),
        ),
        BlocProvider(create: (context) => SoBloc()
            // ..add(GetSessionEvent()),
            ),
        BlocProvider(
          create: (context) => ListSoBloc()..add(GetSoByUserIdEvent()),
        ),
        BlocProvider(
          create: (context) => UserBloc()..add(CheckSessionEvent()),
        )
      ],
      child: MaterialApp(
        title: 'Armada Gilang',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.indigo,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('id', '')],
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return const AssignedJobListPage();
            } else {
              return const LoginPage();
            }
          },
        ),
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

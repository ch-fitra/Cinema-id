import 'package:cinema_id_v1/page/login/login.dart';
import 'package:cinema_id_v1/provider/provider_dark_mode.dart';
import 'package:cinema_id_v1/provider/provider_film.dart';
import 'package:cinema_id_v1/provider/provider_tiket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilmProv(),
        ),
        ChangeNotifierProvider(
          create: (context) => TiketProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkMode(),
        )
      ],
      child: Consumer<DarkMode>(builder: (_, value, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
          theme: value.themeData,
        );
      }),
    );
  }
}

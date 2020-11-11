import 'package:flutter/material.dart';

import './app_styling.dart';
import './home.dart';
import './game_screen.dart';

void main() {
  // debugPrintGestureArenaDiagnostics = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Connect Puzzle',
        theme: ThemeData(
            primarySwatch: AppColors.THEME_PRIMARY_SWATCH,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonBarTheme: ButtonBarThemeData(
              alignment: MainAxisAlignment.spaceAround,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors.BUTTON_THEME_CLR,
              textTheme: ButtonTextTheme.primary,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(title: 'Circuit Connect HOME'),
          '/game': (context) => GameScreen(title: 'Circuit Connect PLAY'),
        });
  }
}

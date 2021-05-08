import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/app_content.dart';
import 'package:gridcircuitpuzzle/home.dart';
import 'package:gridcircuitpuzzle/game.dart';
import 'package:gridcircuitpuzzle/settings.dart';

void main() {
  // debugPrintGestureArenaDiagnostics = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppText.APP_TITLE,
        theme: ThemeData(
            primarySwatch: AppColors.themePrimarySwatch,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonBarTheme: ButtonBarThemeData(
              alignment: MainAxisAlignment.spaceAround,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors.buttonThemeColor,
              textTheme: ButtonTextTheme.primary,
            )),
        initialRoute: '/',
        routes: {
          // '/': (context) => HomeScreen(title: 'Circuit Connect HOME'),
          '/game': (context) => HomeScreen(title: 'Circuit Connect HOME'),
          '/': (context) => GameScreen(title: 'Circuit Connect PLAY'),
          // '/game': (context) => GameScreen(title: 'Circuit Connect PLAY'),
        });
  }
}

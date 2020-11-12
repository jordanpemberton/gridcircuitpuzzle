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
          '/': (context) => HomeScreen(title: AppText.HOME_TITLE),
          '/game': (context) => GameScreen(title: AppText.GAME_TITLE),
          '/settings': (context) => SettingsScreen(title: AppText.SETT_TITLE),
        });
  }
}

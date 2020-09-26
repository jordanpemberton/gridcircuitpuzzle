import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'home.dart';
import 'game_screen.dart';



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
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonBarTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceAround,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(title: 'Circuit Connect HOME'),
          '/game': (context) => GameScreen(title: 'Circuit Connect PLAY'),
        });
  }
}

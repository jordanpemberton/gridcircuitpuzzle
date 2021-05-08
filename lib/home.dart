import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/settings.dart';
import 'package:gridcircuitpuzzle/app_content.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: AppPaddings.PAD_HOME_PG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/game');
                },
                child: Text(AppText.HOME_GAME_BTN_TXT),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SettingsScreen(title: AppText.SETT_TITLE)));
                },
                child: Text(AppText.HOME_SETT_BTN_TXT),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

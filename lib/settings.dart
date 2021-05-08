import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_content.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
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
              Text('Settings...'),
            ],
          ),
        ),
      ),
    );
  }
}

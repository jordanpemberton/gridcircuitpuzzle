import 'package:flutter/material.dart';

class WinAlert extends StatelessWidget {
  final Color _color = Colors.grey[300];
  final String _title = 'You Win!';
  final String _content = 'Congrats :)';
  final String _home = 'Home';
  final String _new = 'New Game';

  final Function onHome;
  final Function onNewGame;

  WinAlert({
    @required this.onHome,
    @required this.onNewGame,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(_title, textAlign: TextAlign.center,),
      content: new Text(_content, textAlign: TextAlign.center,),
      backgroundColor: _color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(_home),
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pop(context);
            onHome();
          },
        ),
        new FlatButton(
          child: Text(_new),
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pop(context);
            onNewGame();
          },
        ),
      ],
    );
  }
}

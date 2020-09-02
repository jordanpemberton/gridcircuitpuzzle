import 'package:flutter/material.dart';

import './board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Puzzle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Circuit Connect'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int _pieceCount = 16;

  Map _game = {
    0: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    1: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    2: {
      't': 1,
      'r': 1,
      'b': 0,
      'l': 1,
      's': 0,
    },
    3: {
      't': -1,
      'r': -1,
      'b': 1,
      'l': 0,
      's': 0,
    },
    4: {
      't': 1,
      'r': 0,
      'b': 1,
      'l': 0,
      's': 0,
    },
    5: {
      't': 1,
      'r': 0,
      'b': 1,
      'l': 1,
      's': 0,
    },
    6: {
      't': 0,
      'r': 0,
      'b': -1,
      'l': 1,
      's': 0,
    },
    7: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    8: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    9: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    10: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    11: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    12: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    13: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    14: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
    15: {
      't': -1,
      'r': -1,
      'b': 0,
      'l': 0,
      's': 0,
    },
  };

  // var moveStack = new List(2);
  int lastSelected;

  void _onPieceTapped(int index) {
    setState(() {
      if (lastSelected == null) {
        _game[index]['s'] = 1;
        lastSelected = index;
      } else if (lastSelected == index) {
        _game[index]['s'] = 0;
        lastSelected = null;
      } else {
        _game[lastSelected]['s'] = 0;
        Map temp = _game[lastSelected];
        _game[lastSelected] = _game[index];
        _game[index] = temp;
        lastSelected = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Board(count: _pieceCount, pieces: _game, func: _onPieceTapped),
          ],
        ),
      ),
    );
  }
}

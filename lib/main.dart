import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  bool _newGame = true;

  Map _game = {
    0: {
      't': 0,
      'r': 1,
      'b': 1,
      'l': 0,
      'c': 0,
      's': 0,
    },
    1: {
      't': 0,
      'r': 0,
      'b': 1,
      'l': 1,
      'c': 0,
      's': 0,
    },
    2: {
      't': 0,
      'r': 1,
      'b': 1,
      'l': 0,
      'c': 0,
      's': 0,
    },
    3: {
      't': 0,
      'r': 0,
      'b': 1,
      'l': 1,
      'c': 0,
      's': 0,
    },
    4: {
      't': 1,
      'r': 1,
      'b': 0,
      'l': 0,
      'c': 0,
      's': 0,
    },
    5: {
      't': 1,
      'r': 1,
      'b': 1,
      'l': 1,
      'c': 1,
      's': 0,
    },
    6: {
      't': 1,
      'r': 1,
      'b': 1,
      'l': 1,
      'c': 2,
      's': 0,
    },
    7: {
      't': 1,
      'r': 0,
      'b': 0,
      'l': 1,
      'c': 1,
      's': 0,
    },
    8: {
      't': 0,
      'r': 1,
      'b': 1,
      'l': 0,
      'c': 0,
      's': 0,
    },
    9: {
      't': 1,
      'r': 1,
      'b': 1,
      'l': 1,
      'c': 2,
      's': 0,
    },
    10: {
      't': 1,
      'r': 1,
      'b': 1,
      'l': 1,
      'c': 1,
      's': 0,
    },
    11: {
      't': 0,
      'r': 0,
      'b': 1,
      'l': 1,
      'c': 0,
      's': 0,
    },
    12: {
      't': 1,
      'r': 1,
      'b': 0,
      'l': 0,
      'c': 0,
      's': 0,
    },
    13: {
      't': 1,
      'r': 0,
      'b': 0,
      'l': 1,
      'c': 0,
      's': 0,
    },
    14: {
      't': 1,
      'r': 1,
      'b': 0,
      'l': 0,
      'c': 0,
      's': 0,
    },
    15: {
      't': 1,
      'r': 0,
      'b': 0,
      'l': 1,
      'c': 0,
      's': 0,
    },
  };

  int _lastSelected;

  bool _solved = true;

  bool _isSolved() {
    for (int i = 0; i < _pieceCount; i++) {
      if (_game[i].containsValue(-1)) {
        return false;
      }
    }
    return true;
  }

  void _shufflePieces() {
    List _indexOrder = [for (int i = 0; i < _pieceCount; i++) i];
    Map _tempGame = {};
    setState(() {
      _indexOrder.shuffle();
      for (int i = 0; i < _pieceCount; i++) {
        _tempGame[_indexOrder[i]] = _game[i];
      }
      _game = _tempGame;
      _newGame = false;

      for (int i = 0; i < _pieceCount; i++) {
        _checkConnections(i);
      }
    });
  }

  void _checkConnectHelper(int indexA, int indexB, String partA, String partB) {
    // print('A: $indexA, $partA = ${_game[indexA][partA]}');
    // print('B: $indexB, $partB = ${_game[indexB][partB]}');
    // nothing here to connect:
    if (_game[indexA][partA] == 0 && _game[indexB][partB] == 0) {
    }
    // not connected:
    else if (_game[indexA][partA] * _game[indexB][partB] == 0) {
      _game[indexA][partA] = _game[indexA][partA] == 0 ? 0 : -1;
      _game[indexB][partB] = _game[indexB][partB] == 0 ? 0 : -1;
      // connected?
    } else {
      _game[indexA][partA] = 1;
      _game[indexB][partB] = 1;
    }
  }

  void _checkConnections(int index) {
    // Side length = square root of length
    int root = (math.sqrt(_pieceCount)).toInt();

    // Above:
    if (index - root >= 0) {
      _checkConnectHelper(index, index - root, 't', 'b');
    } else {
      _game[index]['t'] = _game[index]['t'] == 0 ? 0 : -1;
    }

    // Below:
    if (index + root < _pieceCount) {
      _checkConnectHelper(index, index + root, 'b', 't');
    } else {
      _game[index]['b'] = _game[index]['b'] == 0 ? 0 : -1;
    }

    // To left:
    if (index - 1 >= 0 && (index % root != 0)) {
      _checkConnectHelper(index, index - 1, 'l', 'r');
    } else {
      _game[index]['l'] = _game[index]['l'] == 0 ? 0 : -1;
    }

    // To right:
    if (((index + 1) < _pieceCount) && ((index + 1) % root != 0)) {
      _checkConnectHelper(index, index + 1, 'r', 'l');
    } else {
      _game[index]['r'] = _game[index]['r'] == 0 ? 0 : -1;
    }
  }

  void _onPieceTapped(int index) {
    setState(() {
      if (_lastSelected == null) {
        _game[index]['s'] = 1;
        _lastSelected = index;
      } else if (_lastSelected == index) {
        _game[index]['s'] = 0;
        _lastSelected = null;
      } else {
        _game[_lastSelected]['s'] = 0;
        Map temp = _game[_lastSelected];
        _game[_lastSelected] = _game[index];
        _game[index] = temp;
        _checkConnections(_lastSelected);
        _checkConnections(index);
        _lastSelected = null;
      }
      // Check if solved:
      if (_isSolved()) {
        print('YOU WIN!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_newGame) {
      _shufflePieces();
    }

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

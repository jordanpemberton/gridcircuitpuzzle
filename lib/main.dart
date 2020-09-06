import 'package:flutter/material.dart';
import 'dart:math';

import './game.dart';
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
  static const int _pieceCount = 100;

  bool _newGame = true;

  // Map _game = Game;
  Map _game;

  int _lastSelected;

  // bool _solved = true;

  Map _makeNewGame() {
    Map game = {
      for (int i = 0; i < _pieceCount; i++)
        i: {
          't': 0,
          'r': 0,
          'b': 0,
          'l': 0,
          'c': 0,
          's': 0,
        },
    };

    int root = (sqrt(_pieceCount)).toInt();

    // Start with corners:
    int A = 0;
    int B = root - 1;
    int C = _pieceCount - 1;
    int D = _pieceCount - root;

    int a = A;
    int b = B;
    int c = C;
    int d = D;

    game = _fillPiece(game, root, a, b, c, d);

    while (a + 1 < B) {
      a += 1;
      b += root;
      c -= 1;
      d -= root;
      game = _fillPiece(game, root, a, b, c, d);
    }

    for (int i = 0; i < root / 2 - 2; i++) {
      // Next level in:
      A += (root + 1);
      B += (root - 1);
      C -= (root + 1);
      D -= (root - 1);

      a = A;
      b = B;
      c = C;
      d = D;

      while (a + 1 < B) {
        a += 1;
        b += root;
        c -= 1;
        d -= root;
        game = _fillPiece(game, root, a, b, c, d);
      }
    }

    _newGame = false;
    return game;
  }

  Map _fillPiece(Map game, int root, int a, int b, int c, int d) {
    final random = Random();

    // Right, bottom for a:
    game[a]['r'] = random.nextBool() ? 1 : 0;
    game[a]['b'] = random.nextBool() ? 1 : 0;

    // Matching components:
    game[a + 1]['l'] = game[a]['r'];
    game[a + root]['t'] = game[a]['b'];

    // Bottom, left for b:
    game[b]['b'] = random.nextBool() ? 1 : 0;
    game[b]['l'] = random.nextBool() ? 1 : 0;

    // Matching components:
    game[b + root]['t'] = game[b]['b'];
    game[b - 1]['r'] = game[b]['l'];

    // Left, top for c:
    game[c]['l'] = random.nextBool() ? 1 : 0;
    game[c]['t'] = random.nextBool() ? 1 : 0;

    // Matching components:
    game[c - 1]['r'] = game[c]['l'];
    game[c - root]['b'] = game[c]['t'];

    // Top, right for d:
    game[d]['t'] = random.nextBool() ? 1 : 0;
    game[d]['r'] = random.nextBool() ? 1 : 0;

    // Matching components:
    game[d - root]['b'] = game[d]['t'];
    game[d + 1]['l'] = game[d]['r'];

    return game;
  }

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
      // _newGame = false;

      for (int i = 0; i < _pieceCount; i++) {
        _checkConnections(i);
      }
    });
  }

  void _checkConnectHelper(int indexA, int indexB, String partA, String partB) {
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
    int root = (sqrt(_pieceCount)).toInt();

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

  void _resetNewGame() {
    setState(() {
      _newGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_newGame) {
      _game = _makeNewGame();
      // _shufflePieces();
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
            RaisedButton(
              onPressed: _resetNewGame,
              child: Text('New Game'),
            )
          ],
        ),
      ),
    );
  }
}

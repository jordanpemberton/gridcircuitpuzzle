import 'package:flutter/material.dart';
import 'dart:math';

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
        primarySwatch: Colors.grey,
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
  static const int _sideLen = 8;

  int _boardLen = _sideLen * _sideLen;

  bool _newGame = true;

  Map _relations;

  Map _game;

  int _lastSelected;

  // bool _solved = true;

  void _initNewGame() {
    _relations = _makeRelationsMap();
    _game = _makeNewGame();
    _shufflePieces();
  }

  Map _makeRelationsMap() {
    Map relations = {
      for (int i = 0; i < _boardLen; i++)
        i: {
          // 0 = Above, 1 = Right, 2 = Below, 3 = Left
          0: i < _sideLen ? false : [i - _sideLen, 2],
          1: (i + 1) % _sideLen == 0 ? false : [i + 1, 3],
          2: i >= (_boardLen - _sideLen) ? false : [i + _sideLen, 0],
          3: i % _sideLen == 0 ? false : [i - 1, 1],
        }
    };
    return relations;
  }

  Map _makeNewGame() {
    final rand = Random();
    
    Map game = {
      for (int i = 0; i < _boardLen; i++)
        i: {
          // 0 = Top, 1 = Right, 2 = Bottom, 3 = Left
          0: _relations[i][0] == false ? 0 : 1,
          1: _relations[i][1] == false ? 0 : 1,
          2: _relations[i][2] == false ? 0 : 1,
          3: _relations[i][3] == false ? 0 : 1,
          'c': rand.nextBool() ? 1 : 2,
          's': 0,
        },
    };

    for (int i = 0; i < _boardLen; i++) {
      _removeArms(game);
    }

    _newGame = false;
    return game;
  }

  Map _removeArms(Map game) {
    final rand = Random();
    int rIndex = rand.nextInt(_boardLen);
    if (game[rIndex][0] + game[rIndex][1] + game[rIndex][2] + game[rIndex][3] >
        2) {
      int rSide = rand.nextInt(4);
      game[rIndex][rSide] = 0;
      var companion = _relations[rIndex][rSide];
      if (companion != false) {
        var companIndex = companion[0];
        var companSide = companion[1];
        game[companIndex][companSide] = 0;
      }
    }
    return game;
  }

  
  void _findIslands(Map game) {
    List visit = _findIslandsHelper(game, 0, [], []);
    print(visit);
  }

  List _findIslandsHelper(Map game, int i, List visited, List toCheck) {
    print(visited);
    print(toCheck);
    visited.add(i);
    toCheck.remove(i);

    if (game[i][0] + game[i][1] + game[i][2] + game[i][3] == 0) {
      return visited;
    }

    int j = 0;
    while (j < 4) {
      if (game[i][j] != 0) {
        if (j == 0 && !visited.contains(i - _sideLen)) {
          toCheck.add(i - _sideLen);
          // return _findIslandsHelper(game, i - _sideLen, visited);
        } else if (j == 1 && !visited.contains(i + 1)) {
          toCheck.add(i + 1);
          // return _findIslandsHelper(game, i + 1, visited);
        } else if (j == 2 && !visited.contains(i + _sideLen)) {
          toCheck.add(i + _sideLen);
          // return _findIslandsHelper(game, i + _sideLen, visited);
        } else if (j == 3 && !visited.contains(i - 1)) {
          toCheck.add(i - 1);
          // return _findIslandsHelper(game, i - 1, visited);
        }
      } else {
        j += 1;
      }
      print(toCheck);
      if (toCheck.length > 0) {
        return _findIslandsHelper(game, toCheck[0], visited, toCheck);
      }
    }

    return visited;
  }

  bool _isSolved() {
    for (int i = 0; i < _boardLen; i++) {
      if (_game[i].containsValue(-1)) {
        return false;
      }
    }
    return true;
  }

  void _shufflePieces() {
    List _indexOrder = [for (int i = 0; i < _boardLen; i++) i];
    Map _tempGame = {};
    setState(() {
      _indexOrder.shuffle();
      for (int i = 0; i < _boardLen; i++) {
        _tempGame[_indexOrder[i]] = _game[i];
      }
      _game = _tempGame;

      for (int i = 0; i < _boardLen; i++) {
        _checkConnections(i);
      }
    });
  }

void _checkConnections(int index) {
    var companion;
    for (int j = 0; j < 4; j++) {
      companion = _relations[index][j];
      // No partner piece:
      if (companion == false) {
        _game[index][j] = _game[index][j] == 0 ? 0 : -1;
      } 
      else {
        // Either one or both are empty -> no connection:
        if (_game[index][j] * _game[companion[0]][companion[1]] == 0) {
          _game[index][j] = _game[index][j] == 0 ? 0 : -1;
          _game[companion[0]][companion[1]] = _game[companion[0]][companion[1]] == 0 ? 0 : -1;
        } 
        // Connected!
        else {
          _game[index][j] = 1;
          _game[companion[0]][companion[1]] = 1;
        }
      }
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
      _initNewGame();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Board(count: _boardLen, pieces: _game, func: _onPieceTapped),
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

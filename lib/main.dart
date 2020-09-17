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
  // The size of the board:
  static const int _sideLen = 8;
  int _boardLen = _sideLen * _sideLen;

  bool _newGame = true;
  // bool _solved = true;

  Map _relations;
  Map _game;

  int _lastSelected;

  void _initNewGame() {
    _relations = _makeRelationsMap();
    _game = _makeNewGame();
    // _shufflePieces();
  }

  bool _isSolved() {
    for (int i = 0; i < _boardLen; i++) {
      if (_game[i].containsValue(-1)) {
        return false;
      }
    }
    return true;
  }

  Map _makeRelationsMap() {
    // Each entry for index n contains companion indexes and sides for each of n's sides,
    // where 0 = top, 1 = right, 2 = bottom, 3 = left.
    // For example on a 4 x 4 grid:
    //    2: {  0: false,     // Above: none
    //          1: [3, 3],    // To right: index 3's left arm
    //          2: [6, 0],    // Below: index 6's top arm
    //          3: [1, 1]   } // To left: index 1's right arm

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
    // For each index (piece) on board, fill all arms (sides) wherever a companion piece exists.
    // Then call _removeArms(game) to remove arm pairs.
    // Set _newGame to false, and return game.

    final rand = Random();

    Map game = {
      for (int i = 0; i < _boardLen; i++)
        i: {
          // 0 = Top, 1 = Right, 2 = Bottom, 3 = Left
          0: _relations[i][0] == false ? 0 : 1,
          1: _relations[i][1] == false ? 0 : 1,
          2: _relations[i][2] == false ? 0 : 1,
          3: _relations[i][3] == false ? 0 : 1,
          'center': rand.nextBool() ? 1 : 2,
          'select': 0,
          'drag': 'drag',
        },
    };

    for (int i = 0; i < _boardLen; i++) {
      _removeArms(game);
    }

    if (_areNoIslands(game)) {
      _newGame = false;
      return game;
    }

    return _makeNewGame();
  }

  Map _removeArms(Map game) {
    // Choose random index, and if that piece has 3+ arms,
    // choose a random arm to remove.
    // If a companion piece/side exists, and companion side also has 3+ arms,
    // remove both arms and return game.

    final rand = Random();
    int rIndex = rand.nextInt(_boardLen);

    if (game[rIndex][0] + game[rIndex][1] + game[rIndex][2] + game[rIndex][3] >
        2) {
      int rSide = rand.nextInt(4);
      var companion = _relations[rIndex][rSide];
      if (companion != false) {
        var companIndex = companion[0];
        var companSide = companion[1];
        if (game[companIndex][0] +
                game[companIndex][1] +
                game[companIndex][2] +
                game[companIndex][3] >
            2) {
          game[rIndex][rSide] = 0;
          game[companIndex][companSide] = 0;
        }
      }
    }
    return game;
  }

  bool _areNoIslands(Map game) {
    // Returns true if all pieces on board are connected (no islands)
    // or else returns false.
    List visited = _findIslands(game, 0, [], []);

    // print('visited: $visited');
    if (visited.length == _boardLen) {
      print('Length = board size :D No islands');
      return true;
    }
    return false;
  }

  List _findIslands(Map game, int i, List visited, List toCheck) {
    // print('visited: $visited');
    // print('toCheck: $toCheck');
    visited.add(i);
    if (toCheck.contains(i)) {
      toCheck.remove(i);
    }

    if (game[i][0] + game[i][1] + game[i][2] + game[i][3] == 0) {
      return visited;
    }

    for (int j = 0; j < 4; j++) {
      if (game[i][j] != 0) {
        if (_relations[i][j] != false) {
          if (!visited.contains(_relations[i][j][0])) {
            if (!toCheck.contains(_relations[i][j][0])) {
              toCheck.add(_relations[i][j][0]);
            }
          }
        }
      }
    }

    if (toCheck.length > 0) {
      return _findIslands(game, toCheck[0], visited, toCheck);
    }

    return visited;
  }

  void _shufflePieces() {
    // Shuffle index order /assign _game children new indexes.
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
    // Given an index, check if each side is connected to it's companion.
    // If connected, set each arm to 1, if not, set to -1 if arm exists, 0 if no arm.
    var companion;
    for (int j = 0; j < 4; j++) {
      companion = _relations[index][j];
      // No partner piece:
      if (companion == false) {
        _game[index][j] = _game[index][j] == 0 ? 0 : -1;
      } else {
        // Either one or both are empty -> no connection:
        if (_game[index][j] * _game[companion[0]][companion[1]] == 0) {
          _game[index][j] = _game[index][j] == 0 ? 0 : -1;
          _game[companion[0]][companion[1]] =
              _game[companion[0]][companion[1]] == 0 ? 0 : -1;
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
        _game[index]['select'] = 1;
        _lastSelected = index;
      } else if (_lastSelected == index) {
        _game[index]['select'] = 0;
        _lastSelected = null;
      } else {
        _game[_lastSelected]['select'] = 0;
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

  void _onDragStart(int index) {
    setState(() {
      _game.forEach((key, value) {
        if (key != index) {
          _game[key]['drag'] = 'target';
        }
      });
      
      if (_lastSelected != null) {
        _game[_lastSelected]['select'] = 0;
        _lastSelected = null;
      }
    });
  }

  void _onDragEnd(DraggableDetails data) {
    setState(() {
      _game.forEach((key, value) {
        _game[key]['drag'] = 'drag';
      });

      if (_lastSelected != null) {
        _game[_lastSelected]['select'] = 0;
        _lastSelected = null;
      }
    });
  }

  void _onDragAccept(int keyA, int keyB) {
    setState(() {
      Map temp = _game[keyA];
      _game[keyA] = _game[keyB];
      _game[keyB] = temp;
      
      _game[keyA]['select'] = 0;
      _game[keyB]['select'] = 0;
      _lastSelected = null;

      _checkConnections(keyA);
      _checkConnections(keyB);
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
            Board(
              count: _boardLen,
              pieces: _game,
              onTapFunc: _onPieceTapped,
              onDragStartFunc: _onDragStart,
              onDragEndFunc: _onDragEnd,
              onDragAcceptFunc: _onDragAccept,
            ),
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

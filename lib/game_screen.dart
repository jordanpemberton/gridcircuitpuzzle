import 'package:flutter/material.dart';
import 'dart:math';
import './game_board.dart';
import './win_alert.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  static int _boardSize = 3;
  static List<String> armKeys = ['top', 'right', 'bottom', 'left'];
  static Map<int, Map<String, dynamic>> _relations = _makeRelationsMap();

  List<Map<String, dynamic>> _pieces =
      List<Map<String, dynamic>>(_boardSize * _boardSize);
  bool _newGame = true;
  bool _solved = true;

  /// Track if game solved with toal connections:
  int _totalArmCount = 4 * (_boardSize * _boardSize) - (4 * _boardSize) - 4;
  int _connectedArmsCount = 0;

  /// need == total arms to win
  int _lastSelected = -1;

  static Map<int, Map<String, dynamic>> _makeRelationsMap() {
    /// Used to find adjacent pieces
    /// For each board index on board:
    /// board index: {
    ///   top: [adj index, adj arm] : false,
    ///   right: [adj index, adj arm] : false,
    ///   bottom: [adj index, adj arm] : false,
    ///   left: [adj index, adj arm] : false,
    /// }
    /// This map doesn't change as pieces move,
    /// is only initialized once.
    int n = _boardSize * _boardSize;
    Map<int, Map<String, dynamic>> relations = {
      for (int i = 0; i < n; i++)
        i: {
          'top': i < _boardSize ? false : [i - _boardSize, 'bottom'],
          'right': (i + 1) % _boardSize == 0 ? false : [i + 1, 'left'],
          'bottom': i >= (n - _boardSize) ? false : [i + _boardSize, 'top'],
          'left': i % _boardSize == 0 ? false : [i - 1, 'right'],
        }
    };
    return relations;
  }

  void _initNewGame() {
    setState(() {
      // _relations = _makeRelationsMap();
      _pieces = _makePieceList();
      _newGame = false;
      _solved = true;
      while (_solved) {
        _pieces = _shufflePieces(_pieces);
        _checkAllConnections();
        _solved = _checkIfSolved();
      }
    });
  }

  bool _checkIfSolved() {
    int n = _boardSize * _boardSize;
    /// Check for any unpaired arms:
    for (int i = 0; i < n; i++) {
      if (_pieces[i].containsValue(-1) == true) {
        return false;
      }
    }
    return true;
  }

  void _gameSolved() {
    /// Solved! Change state
    setState(() {
      print('YOU WIN!');
      _solved = true;
      showDialog(
        context: context,
        builder: (_) {
          return WinAlert(
            onHome: _returnHome,
            onNewGame: _resetNewGame,
          );
        },
      );
    });
  }

  List<Map<String, dynamic>> _makePieceList() {
    /// For each index on board, first fill all armKeys
    /// wherever a adjacent index exists.
    /// Then call _removeArms(game) to remove arm pairs.
    /// Set _newGame to false, and return game.
    int n = _boardSize * _boardSize;
    List<Map<String, dynamic>> game = List<Map<String, dynamic>>(n);

    for (int i = 0; i < n; i++) {
      Map<String, dynamic> newPiece = {
        'top': _relations[i]['top'] == false ? 0 : 1,
        'right': _relations[i]['right'] == false ? 0 : 1,
        'bottom': _relations[i]['bottom'] == false ? 0 : 1,
        'left': _relations[i]['left'] == false ? 0 : 1,
        'select': false,
      };
      game[i] = newPiece;
    }

    game = _removeArms(game);

    /// Check for islands:
    if (_areThereIslands(game) == true) {
      /// Try again (recursive self call):
      return _makePieceList();
    }
    return game;
  }

  List<Map<String, dynamic>> _removeArms(List<Map<String, dynamic>> game) {
    /// Choose random index, and if that piece has 3+ arms,
    /// choose a random arm to remove.
    /// If an adjacent piece exists, and the adjacent
    /// piece also has 3+ arms, remove both arms in the pair
    /// Return game.
    int n = _boardSize * _boardSize;
    Random rand = Random();
    int removedCount = 0;
    int count = 0;

    while (count < n) {
      /// Pick a random index on board:
      int i = rand.nextInt(n);

      /// If more than 2 arms, can remove from:
      if (game[i]['top'] +
              game[i]['right'] +
              game[i]['bottom'] +
              game[i]['left'] >
          2) {
        /// Pick a random arm /side to remove:
        int j = rand.nextInt(4);
        String arm = armKeys[j];

        /// Adjacent piece from relations map:
        var adj = _relations[i][arm];

        /// If there is an adjacent piece:
        if (adj != false) {
          /// Check if adj has at least 2 arms (valid to remove from):
          if (game[adj[0]]['top'] +
                  game[adj[0]]['right'] +
                  game[adj[0]]['bottom'] +
                  game[adj[0]]['left'] >
              2) {
            /// Remove both arms:
            game[i][arm] = 0;
            game[adj[0]][adj[1]] = 0;
            removedCount += 2;
          }
        }
      }
      count += 1;
    }
    return game;
  }

  bool _areThereIslands(List<Map<String, dynamic>> game) {
    /// Use BFS to search connections on board.
    /// If all pieces on board are connected (no islands)
    /// returns true, else returns false.
    int n = _boardSize * _boardSize;
    List<int> visited = List();
    List<int> q = List.from([0]);
    int curr;

    while (0 < q.length && q.length < n) {
      curr = q[0];
      q.removeAt(0);
      visited.add(curr);
      /// Check all sides:
      for (int j = 0; j < 4; j++) {
        /// If arm exists:
        if (game[curr][armKeys[j]] != 0) {
          /// If connected adj piece *not yet visited or in queue*:
          var adj = _relations[curr][armKeys[j]];
          if (adj != false) {
            if (visited.contains(adj[0]) == false &&
                q.contains(adj[0]) == false) {
              /// Add the adj piece to the queue to check:
              q.add(_relations[curr][armKeys[j]][0]);
            }
          }
        }
      }
    }
    if (visited.length != n) {
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> _shufflePieces(List<Map<String, dynamic>> pieces) {
    /// Shuffle index order of piece list.
    pieces.shuffle();
    return pieces;
  }

  void _checkAllConnections() {
    int n = _boardSize * _boardSize;
    for (int i = 0; i < n; i++) {
      _checkConnectionsFor(i);
    }
  }

  void _checkConnectionsFor(int index) {
    /// Given an index, check if each arm is now connected to an adj arm.
    /// If connected, set both armKeys to 1.
    /// If not connected, if armKeys exist, set to -1.
    setState(() {
      for (int j = 0; j < 4; j++) {
        String arm = armKeys[j];

        /// Adj piece/arm exists:
        if (_relations[index][arm] != false) {
          List<dynamic> adj = _relations[index][arm];

          /// Either one or both arms are empty -> no connection:
          if (_pieces[index][arm] == 0 || _pieces[adj[0]][adj[1]] == 0) {
            if (_pieces[index][arm] == 1) {
              _pieces[index][arm] = -1;
            }
            if (_pieces[adj[0]][adj[1]] == 1) {
              _pieces[adj[0]][adj[1]] = -1;
            }
          }

          /// Two arms exist -> connection!
          else {
            _pieces[index][arm] = 1;
            _pieces[adj[0]][adj[1]] = 1;
          }
        }

        /// No adj piece:
        else {
          _pieces[index][arm] = _pieces[index][arm] == 0 ? 0 : -1;
        }
      }
    });
  }

  void _onTap(int index) {
    // print('$index TAPPED');
    setState(() {
      /// If no previous tapped piece -> select curr:
      if (_lastSelected == -1) {
        _pieces[index]['select'] = true;
        _lastSelected = index;

        /// If re-tapping same piece -> unselect curr:
      } else if (_lastSelected == index) {
        _pieces[index]['select'] = false;
        _lastSelected = -1;

        /// Else -> swap the curr and previous:
      } else {
        Map<String, dynamic> temp = _pieces[_lastSelected];
        _pieces[_lastSelected] = _pieces[index];
        _pieces[index] = temp;
        _checkConnectionsFor(_lastSelected);
        _checkConnectionsFor(index);

        /// Unselect pieces:
        _pieces[index]['select'] = false;
        _pieces[_lastSelected]['select'] = false;

        /// Set last selected to none:
        _lastSelected = -1;
      }

      /// Check if solved:
      _solved = _checkIfSolved();
      if (_solved) {
        _gameSolved();
      }
    });
  }

  void _returnHome() {
    setState(() {
      _solved = false;
      _newGame = true;
    });
  }

  void _resetNewGame() {
    setState(() {
      _solved = false;
      _newGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_newGame == true) {
      _initNewGame();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: GameBoard(
                  size: _boardSize,
                  pieces: _pieces,
                  onTap: _onTap,
                ),
                // child: Container(),
              ),
              RaisedButton(
                onPressed: _resetNewGame,
                child: Text('New Game'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  static const int pieceCount = 9;

  static const Map game = {
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
      's': 1,
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
  };

  List pieceList = [ for (var i=0; i<pieceCount; i++) game[i] ];
  
  var currentMove = new List(2);

  void makePieceList() {
    setState(() {
      game.forEach((k,v) => pieceList[k] = v);
    });
  }

  void _onPieceTapped() {
    return;
  //   setState(() {
  //     // Current piece (matches key):
  //     int currIndex =
  //         gamePieces.indexWhere((item) => item['pieceKey'] == pieceKey);
  //     Map currPiece = gamePieces[currIndex];

  //     // If reclicked same piece -> Unselect:
  //     if (currentMove['firstPiece'] == pieceKey) {
  //       currentMove['firstPiece'] = null;
  //       currPiece['selected'] = 0;
  //     }

  //     // Select First Piece:
  //     else if (currentMove['firstPiece'] == null) {
  //       currentMove['firstPiece'] = pieceKey;
  //       currPiece['selected'] = 1;
  //     }

  //     // Select Second Piece:
  //     else {
  //       currentMove['secondPiece'] = pieceKey;

  //       int prevKey = currentMove['firstPiece'];

  //       // Find first (prev) selected piece (the piece being moved):
  //       int prevIndex =
  //           gamePieces.indexWhere((item) => item['pieceKey'] == prevKey);
  //       Map prevPiece = gamePieces[prevIndex];
  //       // Unselect
  //       prevPiece['selected'] = 0;

  //       // Swap places in list:
  //       gamePieces[prevIndex] = currPiece;
  //       gamePieces[currIndex] = prevPiece;

  //       // Reset currentMove:
  //       currentMove['firstPiece'] = null;
  //       currentMove['secondPiece'] = null;
  //     }
  //   });
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
            Board(pieceList, _onPieceTapped),
          ],
        ),
      ),
    );
  }
}

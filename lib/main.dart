import 'package:flutter/material.dart';
// import 'dart:async';

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
  List gamePieces = [
    {
      'pieceKey': 1,
      'center': 3,
      'top': 0,
      'right': 0,
      'bottom': 0,
      'left': 1,
      'selected': 0,
    },
    {
      'pieceKey': 2,
      'center': 1,
      'top': 1,
      'right': 0,
      'bottom': 1,
      'left': 0,
      'selected': 0,
    },
    {
      'pieceKey': 3,
      'center': 3,
      'top': 0,
      'right': 0,
      'bottom': 0,
      'left': 1,
      'selected': 0,
    },
    {
      'pieceKey': 4,
      'center': 1,
      'top': 1,
      'right': 1,
      'bottom': 0,
      'left': 0,
      'selected': 0,
    },
    {
      'pieceKey': 5,
      'center': 3,
      'top': 0,
      'right': 2,
      'bottom': 0,
      'left': 0,
      'selected': 0,
    },
    {
      'pieceKey': 6,
      'center': 1,
      'top': 0,
      'right': 1,
      'bottom': 1,
      'left': 0,
      'selected': 0,
    },
    {
      'pieceKey': 7,
      'center': 3,
      'top': 2,
      'right': 0,
      'bottom': 0,
      'left': 0,
      'selected': 0,
    },
    {
      'pieceKey': 8,
      'center': 1,
      'top': 0,
      'right': 1,
      'bottom': 0,
      'left': 1,
      'selected': 0,
    },
    {
      'pieceKey': 9,
      'center': 2,
      'top': 0,
      'right': 0,
      'bottom': 2,
      'left': 2,
      'selected': 0,
    },
  ];

  Map currentMove = {
    'firstPiece': null,
    'secondPiece': null,
  };

  void _onPieceTapped(int pieceKey) {
    setState(() {
      // Current piece (matches key):
      int currIndex = gamePieces.indexWhere((item) => item['pieceKey'] == pieceKey);
      Map currPiece = gamePieces[currIndex];

      // If reclicked same piece -> Unselect:
      if (currentMove['firstPiece'] == pieceKey) {
        currentMove['firstPiece'] = null;
        currPiece['selected'] = 0;
      }

      // Select First Piece:
      else if (currentMove['firstPiece'] == null) {
        currentMove['firstPiece'] = pieceKey;
        currPiece['selected'] = 1;
      }

      // Select Second Piece:
      else {
        currentMove['secondPiece'] = pieceKey;
        
        int prevKey = currentMove['firstPiece'];

        // Find first (prev) selected piece (the piece being moved):
        int prevIndex = gamePieces.indexWhere((item) => item['pieceKey'] == prevKey);
        Map prevPiece = gamePieces[prevIndex];
        // Unselect
        prevPiece['selected'] = 0;

        // Swap places in list:
        gamePieces[prevIndex] = currPiece;
        gamePieces[currIndex] = prevPiece;

        // Reset currentMove:
        currentMove['firstPiece'] = null;
        currentMove['secondPiece'] = null;
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
            Board(gamePieces, _onPieceTapped),
          ],
        ),
      ),
    );
  }
}

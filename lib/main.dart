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
      home: MyHomePage(title: 'Puzzle Home Page'),
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
      'top': false,
      'right': true,
      'bottom': true,
      'left': false,
      'selected': false,
    },
    {
      'pieceKey': 2,
      'top': true,
      'right': false,
      'bottom': false,
      'left': true,
      'selected': false,
    },
    {
      'pieceKey': 3,
      'top': false,
      'right': false,
      'bottom': false,
      'left': true,
      'selected': false,
    },
    {
      'pieceKey': 4,
      'top': true,
      'right': true,
      'bottom': true,
      'left': true,
      'selected': false,
    },
    {
      'pieceKey': 5,
      'top': true,
      'right': true,
      'bottom': false,
      'left': false,
      'selected': false,
    },
    {
      'pieceKey': 6,
      'top': true,
      'right': false,
      'bottom': false,
      'left': false,
      'selected': false,
    },
    {
      'pieceKey': 7,
      'top': false,
      'right': false,
      'bottom': true,
      'left': true,
      'selected': false,
    },
    {
      'pieceKey': 8,
      'top': true,
      'right': true,
      'bottom': true,
      'left': false,
      'selected': false,
    },
    {
      'pieceKey': 9,
      'top': false,
      'right': false,
      'bottom': true,
      'left': false,
      'selected': false,
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
        currPiece['selected'] = false;
      }

      // Select First Piece:
      else if (currentMove['firstPiece'] == null) {
        currentMove['firstPiece'] = pieceKey;
        currPiece['selected'] = true;
      }

      // Select Second Piece:
      else {
        currentMove['secondPiece'] = pieceKey;
        
        int prevKey = currentMove['firstPiece'];

        // Find first (prev) selected piece (the piece being moved):
        int prevIndex = gamePieces.indexWhere((item) => item['pieceKey'] == prevKey);
        Map prevPiece = gamePieces[prevIndex];
        // Unselect
        prevPiece['selected'] = false;

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

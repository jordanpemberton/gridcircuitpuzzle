import 'package:flutter/material.dart';
import './gamepiece.dart';
import 'dart:math';

class Board extends StatelessWidget {
  Board({
    this.count,
    this.pieces,
    this.onTapFunc,
    this.onDragStartFunc,
    this.onDragEndFunc,
    this.onDragAcceptFunc,
  });
  
  final num count;
  final Map pieces;
  final Function onTapFunc;
  final Function onDragStartFunc;
  final Function onDragEndFunc;
  final Function onDragAcceptFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: (sqrt(count)).toInt(),
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        physics: NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < count; i++)
            GamePiece(
              index: i,
              data: pieces[i],
              onTap: onTapFunc,
              onDragStart: onDragStartFunc,
              onDragEnd: onDragEndFunc,
              onDragAccept: onDragAcceptFunc,
            ),
        ],
      ),
    );
  }
}

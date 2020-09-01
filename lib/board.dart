import 'package:flutter/material.dart';
import './gamepiece.dart';

class Board extends StatelessWidget {
  Board(this.pieces, this.onTapFunction);
  final List pieces;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        physics: NeverScrollableScrollPhysics(),
        children: [
          ...pieces.map((piece) => GamePiece(data: piece, func: onTapFunction,)),
        ],
      ),
    );
  }
}

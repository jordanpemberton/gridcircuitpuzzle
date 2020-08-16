import 'package:flutter/material.dart';
import './gamepiece.dart';

class Board extends StatelessWidget {
  Board(this.gamePieces, this.onTapFunction);
  final List gamePieces;
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
          
          ...gamePieces.map((piece) {
            return GamePiece(
              pieceData: piece,
              pieceTapped: onTapFunction,
            );
          }).toList()
        ],
      ),
    );
  }
}

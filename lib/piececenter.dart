import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/piecepart.dart';

class PieceCenter extends StatelessWidget {
  PieceCenter({
    this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    bool allFour = (data['t']).abs() + (data['r']).abs() + (data['b']).abs() + (data['l']).abs() == 4;
    bool allConnect = data['t'] >= 0 && data['r'] >= 0 && data['b'] >= 0 && data['l'] >= 0;

    return Stack(
      children: [
        if (data['t'] == 0 || allFour && data['c'] == 2)
          PiecePart(
            align: Alignment.topCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
            hglt: allConnect,
          ),
        if (data['r'] == 0 || allFour && data['c'] == 1)
          PiecePart(
            align: Alignment.centerRight,
            widthf: 1 / 4,
            heightf: 1 / 2,
            hglt: allConnect,
          ),
        if (data['b'] == 0 || allFour && data['c'] == 2)
          PiecePart(
            align: Alignment.bottomCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
            hglt: allConnect,
          ),
        if (data['l'] == 0 || allFour && data['c'] == 1)
          PiecePart(
            align: Alignment.centerLeft,
            widthf: 1 / 4,
            heightf: 1 / 2,
            hglt: allConnect,
          ),
        PiecePart(
          align: Alignment.topLeft,
          widthf: 1 / 4,
          heightf: 1 / 4,
          hglt: allConnect,
        ),
        PiecePart(
          align: Alignment.topRight,
          widthf: 1 / 4,
          heightf: 1 / 4,
          hglt: allConnect,
        ),
        PiecePart(
          align: Alignment.bottomRight,
          widthf: 1 / 4,
          heightf: 1 / 4,
          hglt: allConnect,
        ),
        PiecePart(
          align: Alignment.bottomLeft,
          widthf: 1 / 4,
          heightf: 1 / 4,
          hglt: allConnect,
        ),
      ],
    );
  }
}

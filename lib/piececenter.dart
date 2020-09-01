import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/piecepart.dart';

class PieceCenter extends StatelessWidget {
  PieceCenter({
    this.data,
  });
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP
        if (data['t'] == 0)
          PiecePart(
            align: Alignment.topCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
          ),
        if (data['r'] == 0)
          PiecePart(
            align: Alignment.centerRight,
            widthf: 1 / 4,
            heightf: 1 / 2,
          ),
        if (data['b'] == 0)
          PiecePart(
            align: Alignment.bottomCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
          ),
        if (data['l'] == 0)
          PiecePart(
            align: Alignment.centerLeft,
            widthf: 1 / 4,
            heightf: 1 / 2,
          ),
        PiecePart(
          align: Alignment.topLeft,
          widthf: 1 / 4,
          heightf: 1 / 4,
        ),
        PiecePart(
          align: Alignment.topRight,
          widthf: 1 / 4,
          heightf: 1 / 4,
        ),
        PiecePart(
          align: Alignment.bottomRight,
          widthf: 1 / 4,
          heightf: 1 / 4,
        ),
        PiecePart(
          align: Alignment.bottomLeft,
          widthf: 1 / 4,
          heightf: 1 / 4,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/piecepart.dart';

class PieceCenter extends StatelessWidget {
  PieceCenter({
    this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    bool allFour = (data[0]).abs() + (data[1]).abs() + (data[2]).abs() + (data[3]).abs() == 4;
    bool allConnect = data[0] >= 0 && data[1] >= 0 && data[2] >= 0 && data[3] >= 0;

    return Stack(
      children: [
        if (data[0] == 0 || allFour && data['center'] == 2)
          PiecePart(
            align: Alignment.topCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
            hglt: allConnect,
          ),
        if (data[1] == 0 || allFour && data['center'] == 1)
          PiecePart(
            align: Alignment.centerRight,
            widthf: 1 / 4,
            heightf: 1 / 2,
            hglt: allConnect,
          ),
        if (data[2] == 0 || allFour && data['center'] == 2)
          PiecePart(
            align: Alignment.bottomCenter,
            widthf: 1 / 2,
            heightf: 1 / 4,
            hglt: allConnect,
          ),
        if (data[3] == 0 || allFour && data['center'] == 1)
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

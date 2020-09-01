import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/piecepart.dart';

class PieceArm extends StatelessWidget {
  PieceArm({
    this.connected,
    this.rotation,
  });
  final int connected;
  final double rotation; // 0, 90, 180, 270

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Stack(
        children: [
          PiecePart(
            align: Alignment.centerLeft,
            widthf: 1 / 4,
            heightf: 1 / 2,
          ),
          PiecePart(
            align: Alignment.centerRight,
            widthf: 1 / 4,
            heightf: 1 / 2,
          ),
          PiecePart(
            align: Alignment.topRight,
            widthf: 1 / 4,
            heightf: 1 / 4,
            hglt: connected == 1,
          ),
          PiecePart(
            align: Alignment.topLeft,
            widthf: 1 / 4,
            heightf: 1 / 4,
            hglt: connected == 1,
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
      ),
    );
  }
}

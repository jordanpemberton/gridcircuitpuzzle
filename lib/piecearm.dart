import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/piecepart.dart';

class PieceArm extends StatelessWidget {
  PieceArm({
    this.localConnect,
    this.allConnect,
    this.rotation,
  });
  final bool localConnect;
  final bool allConnect;
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
            hglt: allConnect,
          ),
          PiecePart(
            align: Alignment.centerRight,
            widthf: 1 / 4,
            heightf: 1 / 2,
            hglt: allConnect,
          ),
          PiecePart(
            align: Alignment.topRight,
            widthf: 1 / 4,
            heightf: 1 / 4,
            hglt: localConnect,
          ),
          PiecePart(
            align: Alignment.topLeft,
            widthf: 1 / 4,
            heightf: 1 / 4,
            hglt: localConnect,
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
      ),
    );
  }
}

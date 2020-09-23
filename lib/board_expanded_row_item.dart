import 'package:flutter/material.dart';
import 'gamepiece_painter.dart';

class BoardExpandedRowItem extends StatelessWidget {
  BoardExpandedRowItem(
    this.piece,
    this.callbacks,
  );

  final List piece;
  final Map callbacks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.0),
            color: Colors.white,
          ),
          // Need to set height at least:
          height: double.infinity,
          // width: double.infinity,
          child: CustomPaint(
            painter: GamePiecePainter(
              this.piece,
            ),
          ),
        ),
      ),
    );
  }
}

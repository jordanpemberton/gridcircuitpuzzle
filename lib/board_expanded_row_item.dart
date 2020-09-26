import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_colors.dart';
import 'package:gridcircuitpuzzle/gamepiece_painter.dart';

class BoardExpandedRowItem extends StatelessWidget {
  BoardExpandedRowItem(
    this.index,
    this.piece,
    this.callbacks,
  );

  final int index;
  final List piece;
  final Map<String, Function> callbacks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        // child: RawGestureDetector(
        child: GestureDetector(
          onTap: () => this.callbacks['onTap'](this.index),
          behavior: HitTestBehavior.translucent,
          // behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.0),
              color: AppColors.PIECE_BG_CLR,
            ),
            // Need to set height at least:
            height: double.infinity,
            width: double.infinity,

            child: CustomPaint(
              painter: GamePiecePainter(
                this.piece,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

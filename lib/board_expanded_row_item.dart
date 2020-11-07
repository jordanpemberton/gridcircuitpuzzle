import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/gamepiece_painter.dart';

class BoardExpandedRowItem extends StatelessWidget {
  BoardExpandedRowItem(
    this.index,
    this.piece,
    this.callbacks,
  );

  final int index;
  final Map piece;
  final Map<String, Function> callbacks;

  @override
  Widget build(BuildContext context) {
    // print(this.piece);

    return Expanded(
      child: Padding(
        padding: AppPaddings.PAD_BTWN_PIECES,
        // child: RawGestureDetector(
        child: GestureDetector(
          onTap: () => this.callbacks['onTap'](this.index),
          // behavior: HitTestBehavior.translucent,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    this.piece['select'] ? Colors.black : AppColors.BOARD_BG_CLR,
                width: 2.0,
              ),
              borderRadius: AppBorderRadii.pieceBorderRadius,
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

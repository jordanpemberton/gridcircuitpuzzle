import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/gamepiece_painter.dart';

class GamePiece extends StatelessWidget {
  GamePiece({
    @required this.index,
    @required this.piece,
    @required this.onTap,
  });

  final int index;
  final Map<String, dynamic> piece;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(this.index),
      // behavior: HitTestBehavior.translucent,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: this.piece['select'] == true
                ? AppColors.PIECE_SEL_BORDER_CLR
                : AppColors.BOARD_BG_CLR,
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
    );
  }
}

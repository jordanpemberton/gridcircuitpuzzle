import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/gamepiece.dart';

class BoardExpandedRowItem extends StatelessWidget {
  BoardExpandedRowItem({
    @required this.index,
    @required this.piece,
    @required this.onTap,
  });

  final int index;
  final Map<String, dynamic> piece;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
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
                width: AppBorderSizes.PIECE_BRDR,
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

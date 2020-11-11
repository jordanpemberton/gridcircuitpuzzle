import 'package:flutter/material.dart';
import './app_styling.dart';
import './gamepiece_painter.dart';

class BoardExpandedRowItem extends StatelessWidget {
  BoardExpandedRowItem({
    @required this.index,
    @required this.piece,
    @required this.onTap,
  });

  final int index;
  final Map piece;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // print(this.piece);

    return Expanded(
      child: Padding(
        padding: AppPaddings.PAD_BTWN_PIECES,
        // child: RawGestureDetector(
        child: GestureDetector(
          onTap: () => this.onTap(this.index),
          // behavior: HitTestBehavior.translucent,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    this.piece['select'] == true ? Colors.black : AppColors.BOARD_BG_CLR,
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

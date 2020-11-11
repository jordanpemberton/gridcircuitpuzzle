import 'package:flutter/material.dart';
import './app_styling.dart';
import './board_expanded_row.dart';

class GameBoard extends StatelessWidget {
  GameBoard({
    @required this.pieces,
    @required this.size,
    @required this.onTap,
  });

  final List pieces;
  final int size;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        padding: AppPaddings.PAD_BOARD_BORDER,
        decoration: BoxDecoration(
          color: AppColors.BOARD_BG_CLR,
          borderRadius: AppBorderRadii.boardBorderRadius,
        ),
        child: Column(
          children: [
            for (int i = 0; i < this.size; i++)
              BoardExpandedRow(
                pieces: this.pieces.sublist((i * this.size), (i * this.size + this.size)),
                indexRowAdjust: this.size * i,
                onTap: this.onTap,
              ),
          ],
        ),
      ),
    );
  }
}

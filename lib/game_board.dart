import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/board_expanded_row.dart';

class GameBoard extends StatelessWidget {
  GameBoard({
    this.pieces,
    this.size,
    this.callbacks,
  });

  final List pieces;
  final int size;
  final Map<String, Function> callbacks;

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
                this
                    .pieces
                    .sublist((i * this.size), (i * this.size + this.size)),
                this.size * i,
                this.callbacks,
              ),
          ],
        ),
      ),
    );
  }
}

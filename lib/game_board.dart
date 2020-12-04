import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/board_expanded_row.dart';


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
      child: FractionallySizedBox(
        widthFactor: AppSizeFactors.BOARD_SIZE_FACT,
        heightFactor: AppSizeFactors.BOARD_SIZE_FACT,
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.BOARD_BG_CLR,
            borderRadius: AppBorderRadii.boardBorderRadius,
          ),
          child: FractionallySizedBox(
            widthFactor: AppSizeFactors.INNER_BOARD_SIZE_FACT,
            heightFactor: AppSizeFactors.INNER_BOARD_SIZE_FACT,
            child: Column(
              children: [
                for (int i = 0; i < this.size; i++)
                  BoardExpandedRow(
                    pieces: this
                        .pieces
                        .sublist((i * this.size), (i * this.size + this.size)),
                    indexRowAdjust: this.size * i,
                    onTap: this.onTap,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

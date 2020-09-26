import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_colors.dart';
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
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppColors.BOARD_BG_CLR,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            for (int i = 0; i < this.size; i++)
              BoardExpandedRow(
                this
                    .pieces
                    .sublist((i * this.size), (i * this.size + this.size)),
                this.callbacks,
              ),
          ],
        ),
      ),
    );
  }
}

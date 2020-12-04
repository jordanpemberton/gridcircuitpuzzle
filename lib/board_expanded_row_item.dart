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
      child: FractionallySizedBox(
        widthFactor: AppSizeFactors.PIECE_SIZE_FACT,
        heightFactor: AppSizeFactors.PIECE_SIZE_FACT,
        alignment: Alignment.center,
        child: GamePiece(
          index: this.index,
          piece: this.piece,
          onTap: this.onTap,
        ),
      ),
    );
  }
}

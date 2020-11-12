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
        child: GamePiece(
          index: this.index,
          piece: this.piece,
          onTap: this.onTap,
        ),
      ),
    );
  }
}

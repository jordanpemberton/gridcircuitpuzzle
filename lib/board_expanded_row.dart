import 'package:flutter/material.dart';
import './board_expanded_row_item.dart';

class BoardExpandedRow extends StatelessWidget {
  BoardExpandedRow(
    this.pieces,
    this.callbacks,
  );

  final List pieces;
  final Map callbacks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < pieces.length; i++)
            BoardExpandedRowItem(
              this.pieces[i],
              this.callbacks,
            ),
        ],
      ),
    );
  }
}

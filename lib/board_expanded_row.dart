import 'package:flutter/material.dart';
import './board_expanded_row_item.dart';

class BoardExpandedRow extends StatelessWidget {
  BoardExpandedRow({
    @required this.pieces,
    @required this.indexRowAdjust,
    @required this.onTap,
  });

  final List pieces;
  final int indexRowAdjust;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // print(this.pieces);
    return Expanded(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < pieces.length; i++)
            BoardExpandedRowItem(
              index: this.indexRowAdjust + i,
              piece: this.pieces[i],
              onTap: this.onTap,
            ),
        ],
      ),
    );
  }
}

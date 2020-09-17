import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

import './piecetile.dart';

class GamePiece extends StatelessWidget {
  GamePiece({
    this.index,
    this.data,
    this.onTap,
    this.onDragStart,
    this.onDragEnd,
    this.onDragAccept,
  });

  final int index;
  final Map data;
  final Function onTap;
  final Function onDragStart;
  final Function onDragEnd;
  final Function onDragAccept;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        color: Color.fromRGBO(230, 230, 230, 1),
        child: GestureDetector(
            onTap: () {
              return onTap(index);
            },
            // This is necessary
            behavior: HitTestBehavior.translucent,
            child: data['drag'] == 'drag'
                ? Draggable<String>(
                    data: index.toString(),
                    child: PieceTile(data: data),
                    feedback: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          color: Color.fromRGBO(230, 230, 230, 1),
                          child: PieceTile(data: data),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          color: Color.fromRGBO(255, 90, 30, 0.2),
                        ),
                      ],
                    ),
                    childWhenDragging: Container(
                      color: Colors.brown[100],
                    ),
                    onDragStarted: () {
                      onDragStart(index);
                    },
                    onDragEnd: (DraggableDetails data) {
                      onDragEnd(data);
                    },
                  )
                : DragTarget<String>(
                    builder: (BuildContext context, List<String> candidateData,
                        List rejectedData) {
                      return PieceTile(
                        data: data,
                      );
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      return onDragAccept(int.parse(data), index);
                    },
                  )),
      ),
    );
  }
}

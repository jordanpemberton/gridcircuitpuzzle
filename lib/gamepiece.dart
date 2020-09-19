import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return
              // Container(
              //   color: Color.fromRGBO(230, 230, 230, 1),
              //   child: GestureDetector(
              //       onTap: () {
              //         HapticFeedback.mediumImpact();
              //         return onTap(index);
              //       },
              //       // This is necessary
              //       behavior: HitTestBehavior.translucent,
              //       child:

              data['drag'] == 'drag'
                  ? Draggable<String>(
                      maxSimultaneousDrags: 1,
                      data: index.toString(),
                      child: Container(
                        color: Colors.grey[300],
                        child: PieceTile(data: data),
                      ),
                      feedback: Material(
                        borderRadius: BorderRadius.circular(5),
                        // elevation: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[400],
                            // border: Border.all(
                            //   color: Colors.grey[350],
                            //   width: 4.0,
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x88222222),
                                offset: const Offset(0, 0),
                                blurRadius: 6,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          child: PieceTile(data: data),
                        ),
                      ),
                      childWhenDragging: Container(
                        color: Colors.grey[400],
                      ),
                      dragAnchor: DragAnchor.child,
                      onDragStarted: () {
                        HapticFeedback.mediumImpact();
                        onDragStart(index);
                      },
                      onDragEnd: (DraggableDetails data) {
                        HapticFeedback.mediumImpact();
                        onDragEnd(data);
                      },
                    )
                  : data['drag'] == 'target'
                      ? DragTarget<String>(
                          builder: (BuildContext context,
                              List<String> candidateData, List rejectedData) {
                            return Container(
                              color: Colors.grey[300],
                              child: PieceTile(data: data),
                            );
                          },
                          onWillAccept: (String data) {
                            return true;
                          },
                          onAccept: (String data) {
                            return onDragAccept(int.parse(data), index);
                          },
                        )
                      : Container();
        },
      ),
    );
  }
}

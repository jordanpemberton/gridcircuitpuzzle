import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:gridcircuitpuzzle/piecearm.dart';
import 'package:gridcircuitpuzzle/piececenter.dart';

class GamePiece extends StatelessWidget {
  GamePiece({
    this.index,
    this.data,
    this.func,
  });

  final int index;
  final Map data;
  final Function func;

  @override
  Widget build(BuildContext context) {
    bool allConnect = data[0] >= 0 && data[1] >= 0 && data[2] >= 0 && data[3] >= 0;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.grey[300],
        child: GestureDetector(
          onTap: () {
            return func(index);
          },
          // This is necessary
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: data['s'] == 1 ? 0.4 : 0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.blue[200],
                ),
              ),
              // TOP
              Align(
                alignment: Alignment.topCenter,
                child: data[0] != 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: PieceArm(
                          localConnect: data[0] == 1,
                          allConnect: allConnect,
                          rotation: 0,
                        ),
                      )
                    : Container(),
              ),
              // RIGHT
              Align(
                alignment: Alignment.centerRight,
                child: data[1] != 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: PieceArm(
                          localConnect: data[1] == 1,
                          allConnect: allConnect,
                          rotation: math.pi / 2,
                        ),
                      )
                    : Container(),
              ),
              // BOTTOM
              Align(
                alignment: Alignment.bottomCenter,
                child: data[2] != 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: PieceArm(
                          localConnect: data[2] == 1,
                          allConnect: allConnect,
                          rotation: math.pi,
                        ),
                      )
                    : Container(),
              ),
              // TOP
              Align(
                alignment: Alignment.centerLeft,
                child: data[3] != 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: PieceArm(
                          localConnect: data[3] == 1,
                          allConnect: allConnect,
                          rotation: math.pi * 1.5,
                        ),
                      )
                    : Container(),
              ),
              // CENTER
              Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 1 / 3,
                    heightFactor: 1 / 3,
                    child: PieceCenter(
                      data: data,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

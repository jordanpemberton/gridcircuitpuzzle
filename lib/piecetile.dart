import 'package:flutter/material.dart';
import 'dart:math' as math;

import './piecearm.dart';
import './piececenter.dart';

class PieceTile extends StatelessWidget {
  PieceTile({
    this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    bool allConnect =
        data[0] >= 0 && data[1] >= 0 && data[2] >= 0 && data[3] >= 0;

    return Stack(
      children: [
        if (data['select'] == 1) 
        AnimatedOpacity(
          opacity: 0.2,
          duration: Duration(milliseconds: 500),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
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
        // LEFT
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
    );
  }
}

import 'package:flutter/material.dart';

class GamePiece extends StatelessWidget {
  GamePiece({
    this.pieceData,
    this.pieceTapped,
  });

  final Map pieceData;
  final Function pieceTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.grey[300],
        // color: selected ? Colors.lightBlue[200] : Colors.grey[300],
        child: GestureDetector(
          onTap: () {
            print(pieceTapped);
            return pieceTapped(pieceData['pieceKey']);
          },
          // This is necessary ?
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: pieceData['selected'] ? 0.4 : 0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.blue[200],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 1 / 3,
                  heightFactor: 1 / 3,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: pieceData['top']
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: pieceData['right']
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: pieceData['bottom']
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: pieceData['left']
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: Colors.blue,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

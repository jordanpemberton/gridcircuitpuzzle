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
        child: GestureDetector(
          onTap: () {
            print(pieceTapped);
            return pieceTapped(pieceData['pieceKey']);
          },
          // This is necessary 
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: pieceData['selected'] == 1 ? 0.4 : 0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.blue[200],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: pieceData['center'] > 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: pieceData['center'] == 3
                              ? Colors.red
                              : pieceData['center'] == 1
                              ? Colors.blue[300]
                              : Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: pieceData['top'] > 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: pieceData['top'] == 1
                              ? Colors.blue[300]
                              : Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: pieceData['right'] > 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: pieceData['right'] == 1
                              ? Colors.blue[300]
                              : Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: pieceData['bottom'] > 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: pieceData['bottom'] == 1
                              ? Colors.blue[300]
                              : Colors.blue,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: pieceData['left'] > 0
                    ? FractionallySizedBox(
                        widthFactor: 1 / 3,
                        heightFactor: 1 / 3,
                        child: Container(
                          color: pieceData['left'] == 1
                              ? Colors.blue[300]
                              : Colors.blue,
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

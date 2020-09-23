import 'package:flutter/material.dart';

class GamePiecePainter extends CustomPainter {
  GamePiecePainter(
    this.piece,
  );

  final List piece;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = Colors.red;

    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      // ..color = Colors.blue[300];
      ..color = Colors.white;

    final path = Path();

    final double r = size.width / 2;

    final double xLeft = 0;
    final double xCenter = size.width / 2;
    final double xRight = size.width;

    final double yTop = 0;
    final double yCenter = size.height / 2;
    final double yBottom = size.height;

    final Offset topCenter = Offset(xCenter, yTop);
    final Offset bottomCenter = Offset(xCenter, yBottom);
    final Offset leftCenter = Offset(xLeft, yCenter);
    final Offset rightCenter = Offset(xRight, yCenter);


    void makeLineBetween(Offset a, Offset b) {
      canvas.drawLine(a, b, paint);
      canvas.drawLine(a, b, paint2);
    }

    void makeArcTo(double x2, double y2) {
      path.arcToPoint(
        Offset(x2, y2),
        radius: Radius.circular(r),
      );
      canvas.drawPath(path, paint);
      canvas.drawPath(path, paint2);
    }


    // If 4 arms:
    if (this.piece.fold(0, (prev, curr) => prev + curr) == 4) {
      makeLineBetween(topCenter, bottomCenter);
      makeLineBetween(leftCenter, rightCenter);
    }

    // If 3 arms:
    else if (this.piece.fold(0, (prev, curr) => prev + curr) == 3) {
      if (this.piece[0] == 0) {
        path.moveTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
      }
      else if (this.piece[1] == 0) {
        path.moveTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
      }
      else if (this.piece[2] == 0) {
        path.moveTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
      }
      else if (this.piece[3] == 0) {
        path.moveTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
      }
    }

    // If 2 arms:
    else if (this.piece.fold(0, (prev, curr) => prev + curr) == 2) {
      // If 2 piece are opposite each other, draw straight line across:
      if (this.piece[0] + this.piece[2] == 2 ||
          this.piece[1] + this.piece[3] == 2) {
        // Vertical:
        if (this.piece[0] == 1) {
          makeLineBetween(topCenter, bottomCenter);
        }
        // Horizontal:
        else {
          makeLineBetween(leftCenter, rightCenter);
        }
      }
      // 2 piece are adjacent, will make an arc:
      else {
        if (this.piece[0] == 1) {
          if (this.piece[1] == 1) {
            path.moveTo(xRight, yCenter);
            makeArcTo(xCenter, yTop);
          }
          else {
            path.moveTo(xCenter, yTop);
            makeArcTo(xLeft, yCenter);
          }
        }
        else if (this.piece[2] == 1) {
          if (this.piece[1] == 1) {
            path.moveTo(xCenter, yBottom);
            makeArcTo(xRight, yCenter);
          }
          else {
            path.moveTo(xLeft, yCenter);
            makeArcTo(xCenter, yBottom);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(GamePiecePainter oldDelegate) => false;
}
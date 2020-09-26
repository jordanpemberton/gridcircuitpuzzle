import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_colors.dart';

class GamePiecePainter extends CustomPainter {
  GamePiecePainter(
    this.piece,
  );

  final List piece;

  @override
  void paint(Canvas canvas, Size size) {
    final paintReg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = AppColors.PIECE_REG_CLR;

    final paintCon = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = AppColors.PIECE_CON_CLR;

    final paintSel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = AppColors.PIECE_SEL_CLR;

    final paintFill = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..color = AppColors.PIECE_FILL_CLR;

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

    void makeLineBetween(Offset a, Offset b, Paint paint) {
      canvas.drawLine(a, b, paint);
      canvas.drawLine(a, b, paintFill);
    }

    void makeArcTo(double x2, double y2, Paint paint) {
      path.arcToPoint(
        Offset(x2, y2),
        radius: Radius.circular(r),
      );
      canvas.drawPath(path, paint);
      canvas.drawPath(path, paintFill);
    }

    int armSum = this.piece.fold(0, (prev, curr) => prev + curr);
    int absArmSum = this.piece.fold(0, (prev, curr) => prev.abs() + curr.abs());
    int vertSum = this.piece[0] + this.piece[2];
    int absVertSum = this.piece[0].abs() + this.piece[2].abs();
    int horzSum = this.piece[1] + this.piece[3];
    int absHorzSum = this.piece[1].abs() + this.piece[3].abs();

    // If 4 arms:
    if (absArmSum == 4) {
      // Vertical:
      makeLineBetween(
          topCenter, bottomCenter, vertSum == 2 ? paintCon : paintReg);
      // Horizontal:
      makeLineBetween(
          leftCenter, rightCenter, horzSum == 2 ? paintCon : paintReg);
    }

    // If 3 arms:
    else if (absArmSum == 3) {
      if (this.piece[0] == 0) {
        path.moveTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom, armSum == 3 ? paintCon : paintReg);
        makeArcTo(xRight, yCenter, armSum == 3 ? paintCon : paintReg);
      } else if (this.piece[1] == 0) {
        path.moveTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter, armSum == 3 ? paintCon : paintReg);
        makeArcTo(xCenter, yBottom, armSum == 3 ? paintCon : paintReg);
      } else if (this.piece[2] == 0) {
        path.moveTo(xRight, yCenter);
        makeArcTo(xCenter, yTop, armSum == 3 ? paintCon : paintReg);
        makeArcTo(xLeft, yCenter, armSum == 3 ? paintCon : paintReg);
      } else if (this.piece[3] == 0) {
        path.moveTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter, armSum == 3 ? paintCon : paintReg);
        makeArcTo(xCenter, yTop, armSum == 3 ? paintCon : paintReg);
      }
    }

    // If 2 arms:
    else if (absArmSum == 2) {
      // If 2 piece are opposite each other, draw straight line between:
      // Vertical:
      if (absVertSum == 2) {
        makeLineBetween(
            topCenter, bottomCenter, vertSum == 2 ? paintCon : paintReg);
      }
      // Horizontal:
      else if (absHorzSum == 2) {
        makeLineBetween(
            leftCenter, rightCenter, horzSum == 2 ? paintCon : paintReg);
      }

      // If 2 piece are adjacent, make an arc between:
      else if (this.piece[0].abs() == 1) {
        if (this.piece[1].abs() == 1) {
          path.moveTo(xRight, yCenter);
          makeArcTo(xCenter, yTop, paintReg);
        } else {
          path.moveTo(xCenter, yTop);
          makeArcTo(xLeft, yCenter, paintReg);
        }
      } else if (this.piece[2].abs() == 1) {
        if (this.piece[1].abs() == 1) {
          path.moveTo(xCenter, yBottom);
          makeArcTo(xRight, yCenter, paintReg);
        } else {
          path.moveTo(xLeft, yCenter);
          makeArcTo(xCenter, yBottom, paintReg);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GamePiecePainter oldDelegate) => false;
}

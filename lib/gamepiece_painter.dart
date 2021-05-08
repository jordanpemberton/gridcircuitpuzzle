import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';

class GamePiecePainter extends CustomPainter {
  GamePiecePainter(
    this.piece,
  );

  final Map piece;

  @override
  void paint(Canvas canvas, Size size) {
    final List pieceArms = [this.piece['top'], 
                            this.piece['right'], 
                            this.piece['bottom'], 
                            this.piece['left']];

    final int armsCount =
        pieceArms.fold(0, (prev, curr) => prev.abs() + curr.abs());
    final int vertCount = pieceArms[0].abs() + pieceArms[2].abs();
    final int horzCount = pieceArms[1].abs() + pieceArms[3].abs();

    final int armSum = pieceArms.fold(0, (prev, curr) => prev + curr);
    final bool allConnected = (armsCount == armSum);

    final paintOuter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * AppStrokeSizes.STROKE_WDTH_F
      ..color =
          allConnected ? AppColors.STROKE_CONN_CLR : AppColors.STROKE_OUT_CLR;

    final paintInner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * AppStrokeSizes.STROKE_WDTH_F / 2
      ..color = AppColors.STROKE_IN_CLR;

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
      canvas.drawLine(a, b, paintOuter);
      canvas.drawLine(a, b, paintInner);
    }

    void makeArcTo(double x2, double y2) {
      path.arcToPoint(
        Offset(x2, y2),
        radius: Radius.circular(r),
      );
      canvas.drawPath(path, paintOuter);
      canvas.drawPath(path, paintInner);
    }

    /// If 4 arms:
    if (armsCount == 4) {
      /// Vertical:
      makeLineBetween(
          topCenter, bottomCenter);
      /// Horizontal:
      makeLineBetween(
          leftCenter, rightCenter);
    }

    /// If 3 arms:
    else if (armsCount == 3) {
      if (pieceArms[0] == 0) {
        path.moveTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
      } else if (pieceArms[1] == 0) {
        path.moveTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
      } else if (pieceArms[2] == 0) {
        path.moveTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
      } else if (pieceArms[3] == 0) {
        path.moveTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
      }
    }

    /// If 2 arms:
    else if (armsCount == 2) {
      /// If 2 piece are opposite each other, draw straight line between:
      /// Vertical:
      if (vertCount == 2) {
        makeLineBetween(
            topCenter, bottomCenter);
      }
      /// Horizontal:
      else if (horzCount == 2) {
        makeLineBetween(
            leftCenter, rightCenter);
      }

      /// If 2 piece are adjacent, make an arc between:
      else if (pieceArms[0] != 0) {
        if (pieceArms[1] != 0) {
          path.moveTo(xRight, yCenter);
          makeArcTo(xCenter, yTop);
        } else {
          path.moveTo(xCenter, yTop);
          makeArcTo(xLeft, yCenter);
        }
      } else if (pieceArms[2] != 0) {
        if (pieceArms[1] != 0) {
          path.moveTo(xCenter, yBottom);
          makeArcTo(xRight, yCenter);
        } else {
          path.moveTo(xLeft, yCenter);
          makeArcTo(xCenter, yBottom);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GamePiecePainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/app_custom_styles.dart';

class GamePiecePainter extends CustomPainter {
  GamePiecePainter(
    this.piece,
  );

  final Map<String, dynamic> piece;

  @override
  void paint(Canvas canvas, Size size) {
    final List pieceArms = [
      this.piece['top'],
      this.piece['right'],
      this.piece['bottom'],
      this.piece['left']
    ];

    final int armsCount =
        pieceArms.fold(0, (prev, curr) => (prev.abs() + curr.abs()).toInt());
    final int vertCount = pieceArms[0].abs() + pieceArms[2].abs();
    final int horzCount = pieceArms[1].abs() + pieceArms[3].abs();

    final int armSum = pieceArms.fold(0, (prev, curr) => (prev + curr).toInt());
    final bool allConnected = (armsCount == armSum);

    final double r = size.width / 2;

    final double xLeft = 0;
    final double xCenter = size.width / 2;
    final double xRight = size.width;

    final double yTop = 0;
    final double yCenter = size.height / 2;
    final double yBottom = size.height;

    final Offset centerCenter = Offset(xCenter, yCenter);
    final Offset topCenter = Offset(xCenter, yTop);
    final Offset bottomCenter = Offset(xCenter, yBottom);
    final Offset leftCenter = Offset(xLeft, yCenter);
    final Offset rightCenter = Offset(xRight, yCenter);

    final path = Path();

    /// Paint() for outer line
    final paintOuter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * AppStrokeSizes.STROKE_WIDTH_OUT
      ..color =
          allConnected ? AppColors.STROKE_CONN_CLR : AppColors.STROKE_OUT_CLR;

    /// Paint() for inner line
    final paintInner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * AppStrokeSizes.STROKE_WIDTH_IN
      ..color = AppColors.STROKE_IN_CLR;

    void makeLineBetween(Offset a, Offset b) {
      /// Draw a straight line between points a and b.
      canvas.drawLine(a, b, paintOuter);
      canvas.drawLine(a, b, paintInner);
    }

    void makeArcTo(double x2, double y2) {
      /// Draw a clock-wise arc from current position
      /// to the given coordinates, x2 and y2.
      /// REQUIRED: Offset FROM (current/starting point)
      /// must be located clockwise from Offset TO (x2, y2),
      /// for the clockwise arc to be correctly drawn.
      path.arcToPoint(
        Offset(x2, y2),
        radius: Radius.circular(r),
      );
      canvas.drawPath(path, paintOuter);
      canvas.drawPath(path, paintInner);
    }

    void makeStraightCornerTo(Offset a, Offset b) {
      /// Draw a straight like 90degree 'corner'
      /// from point a to center to point b.
      /// Point a --> center
      makeLineBetween(a, centerCenter);
      /// Center --> point b
      makeLineBetween(centerCenter, b);
    }

    /// If 4 arms
    if (armsCount == 4) {
      /// Vertical line Top->Bottom
      makeLineBetween(topCenter, bottomCenter);
      /// Horizontal line Left->Right
      makeLineBetween(leftCenter, rightCenter);
    }

    /// If 3 arms
    else if (armsCount == 3) {
      if (pieceArms[0] == 0) {
        if (AppCustomStyles.painterLineType == 'arc') {
          
        }
        /// Connect Left->Bottom->Right
        path.moveTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
      } else if (pieceArms[1] == 0) {
        /// Connect Top->Left->Bottom
        path.moveTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
        makeArcTo(xCenter, yBottom);
      } else if (pieceArms[2] == 0) {
        /// Connect Right->Top->Left
        path.moveTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
        makeArcTo(xLeft, yCenter);
      } else if (pieceArms[3] == 0) {
        /// Connect Bottom->Right->Top
        path.moveTo(xCenter, yBottom);
        makeArcTo(xRight, yCenter);
        makeArcTo(xCenter, yTop);
      }
    }

    /// If 2 arms
    else if (armsCount == 2) {
      /// If 2 piece are opposite each other, draw straight line between:
      /// Vertical line Top->Bottom
      if (vertCount == 2) {
        makeLineBetween(topCenter, bottomCenter);
      }

      /// Horizontal line Left->Right
      else if (horzCount == 2) {
        makeLineBetween(leftCenter, rightCenter);
      }

      /// If 2 piece are adjacent, make an arc between:
      else if (pieceArms[0] != 0) {
        if (pieceArms[1] != 0) {
          /// Arc Right->Top
          path.moveTo(xRight, yCenter);
          makeArcTo(xCenter, yTop);
        } else {
          /// Arc Top->Left
          path.moveTo(xCenter, yTop);
          makeArcTo(xLeft, yCenter);
        }
      } else if (pieceArms[2] != 0) {
        if (pieceArms[1] != 0) {
          /// Arc Bottom->Right
          path.moveTo(xCenter, yBottom);
          makeArcTo(xRight, yCenter);
        } else {
          /// Arc Left->Bottom
          path.moveTo(xLeft, yCenter);
          makeArcTo(xCenter, yBottom);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GamePiecePainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor THEME_PRIMARY_SWATCH = Colors.blueGrey;
  static const Color BUTTON_THEME_CLR = Colors.blueGrey;
  static const Color BOARD_BG_CLR = Color(0xFF45B4C5);
  static const Color PIECE_BG_CLR = Color(0xFFB5EFF1);
  static const Color STROKE_OUT_CLR = Color(0xFF3D8666);
  static const Color STROKE_CONN_CLR = Color(0xFFDD9944);
  static const Color STROKE_IN_CLR = Color(0xFFD5FFF1);
}

class AppStrokeSizes {
  static const double STROKE_WDTH_F = 0.1;
}

class AppBorderSizes {
  static const double PIECE_BRDR = 2.0;
}

class AppPaddings {
  // Make relative...
  static const double PAD_PIECES_F = 0.05;
  static const double PAD_BOARD = 4.0;

  static const EdgeInsets PAD_BTWN_PIECES = EdgeInsets.all(2.0);
  static const EdgeInsets PAD_BOARD_BORDER = EdgeInsets.all(4.0);
}

class AppBorderRadii {
  static BorderRadius boardBorderRadius = BorderRadius.circular(5.0);
  static BorderRadius pieceBorderRadius = BorderRadius.circular(2.0);
}
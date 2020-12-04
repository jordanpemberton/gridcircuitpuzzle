import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor THEME_PRIMARY_SWATCH = Colors.blueGrey;
  static const MaterialColor BUTTON_THEME_CLR = Colors.blueGrey;
  static const Color BOARD_BG_CLR = Color(0xFF45B4C5);
  static const Color PIECE_BG_CLR = Color(0xFFB5EFF1);
  static const Color PIECE_SEL_BORDER_CLR = Color(0xFF000000);
  static const Color STROKE_OUT_CLR = Color(0xFF3D8666);
  static const Color STROKE_CONN_CLR = Color(0xFFDD9944);
  static const Color STROKE_IN_CLR = Color(0xFFD5FFF1);
  static const Color DIALOG_BG_CLR = Color(0xFFDDDDDD);
}

class AppStrokeSizes {
  /// Stroke width factors
  /// (Relative to container size.width)
  static const double STROKE_WIDTH_OUT = 0.12;
  static const double STROKE_WIDTH_IN = 0.06;
}

class AppPaddings {
  static const EdgeInsets PAD_HOME_PG = EdgeInsets.all(24.0);
  // static const EdgeInsets PAD_BOARD_BORDER = EdgeInsets.all(4.0);
  // static const EdgeInsets PAD_BTWN_PIECES = EdgeInsets.all(2.0);
}

class AppSizeFactors {
  /// Using FractionallySizedBox (instead of padding)
  static const double BOARD_SIZE_FACT = 0.95;
  static const double INNER_BOARD_SIZE_FACT = 0.95;
  static const double PIECE_SIZE_FACT = 0.95;
}

class AppBorderRadii {
  static BorderRadius boardBorderRadius = BorderRadius.circular(5.0);
  static BorderRadius pieceBorderRadius = BorderRadius.circular(3.0);
  static BorderRadius dialogBorderRadius = BorderRadius.circular(15.0);
}

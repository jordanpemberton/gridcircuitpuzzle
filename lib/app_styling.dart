import 'package:flutter/material.dart';

// class className {
// fields
// getters/setters
// constructor
// methods/functions
// }

class SavedColors {
  static const List<Color> _blacks = [
    Color(0xFF030301),
  ];
  static const List<Color> _greys = [
    Color(0xFFB89F88),
    Color(0xFFE6DED2),
  ];
  static const List<Color> _offwhites = [
    Color(0xFFEEDFAD),
    Color(0xFFD5A785),
  ];
  static const List<Color> _browns = [
    Color(0xFF774A29),
    Color(0xFF6B4424),
    Color(0xFF4C2F1A),
    Color(0xFF1E130A),
  ];
  static const List<Color> _oranges = [
    Color(0xFFD44B1E),
    Color(0xFFE22712),
  ];
  static const List<Color> _reds = [
    Color(0xFF90190C),
    Color(0xFF580403),
  ];
  static const List<Color> _teals = [
    Color(0xFFD5FFF1),
    Color(0xFFB5EFF1),
    Color(0xFF45B4C5),
    Color(0xFF3D8666),
  ];

  // getters
  List<Color> get blacks {
    return _blacks;
  }

  List<Color> get greys {
    return _greys;
  }

  List<Color> get offwhites {
    return _offwhites;
  }

  List<Color> get browns {
    return _browns;
  }

  List<Color> get oranges {
    return _oranges;
  }

  List<Color> get reds {
    return _reds;
  }

  List<Color> get teals {
    return _teals;
  }
}

class AppColors {
  static SavedColors saved = SavedColors();

  static MaterialColor themePrimarySwatch = Colors.brown;
  static MaterialColor buttonThemeColor = Colors.red;

  static Color boardBGColor = saved.greys[0];
  // static Color pieceBorderRestingColor = saved.browns[0];
  static Color pieceBorderRestingColor = Colors.brown;

  static Color pieceBGColor = saved.greys[1];
  static Color pieceBorderHiLtColor = saved.oranges[0];
  static Color strokeOuterColor = saved.reds[0];
  static Color strokeOuterHiLtColor = saved.oranges[1];
  static Color strokeInnerColor = saved.offwhites[1];
  static Color diaglogBGColor = saved.greys[0];
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
  static BorderRadius boardBorderRadius = BorderRadius.circular(6.0); //6
  static BorderRadius pieceBorderRadius = BorderRadius.circular(5.0); //5
  static BorderRadius dialogBorderRadius = BorderRadius.circular(15.0); //15
}

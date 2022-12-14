import 'package:flutter/material.dart';

class SyncColor {
  SyncColor._();

  static final MaterialColor primarySwatch = hexColor2MaterialColor(0xFF9642EE);
  static const Color primaryColor = Color(0xFF9642EE);
  static const Color hintColor = Color(0xffaaaaaa);
  static const Color unselectedWidgetColor = Color(0xffcccccc);
  static const Color scaffoldBackgroundColor = Color(0xff111111);
  static const Color syncBlack = Color(0xff111111);
}

MaterialColor hexColor2MaterialColor(int hexColor) {
  final Color color = Color(hexColor);
  final r = color.red;
  final g = color.green;
  final b = color.blue;
  return MaterialColor(
    hexColor,
    <int, Color>{
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    },
  );
}

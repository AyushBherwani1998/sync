import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/fonts.dart';
import 'package:flutter_calendar/config/sync_colors.dart';

class SyncTheme {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: SyncColor.primarySwatch,
    primaryColor: SyncColor.primaryColor,
    hintColor: SyncColor.hintColor,
    appBarTheme: _appBarTheme,
    fontFamily: Fonts.defaultFont,
    scaffoldBackgroundColor: SyncColor.scaffoldBackgroundColor,
    unselectedWidgetColor: SyncColor.unselectedWidgetColor,
    accentColor: SyncColor.primaryColor,
  );

  static final AppBarTheme _appBarTheme = AppBarTheme(
    color: const Color(0xff111111),
    elevation: 2,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: SyncColor.primarySwatch),
    actionsIconTheme: IconThemeData(color: SyncColor.primarySwatch),
//    textTheme: TextTheme(
//      title: TextStyle(
//        color: Colors.white,
//        fontSize: 22,
//        fontWeight: FontWeight.w500,
//      ),
//    ),
  );
}

import 'package:flutter/material.dart';

getThemeData(int color) {
  print('getThemeData===================================$color');
  ThemeData themData =
  ThemeData(primaryColor: Color(color == 0 ? Colors.red.value : color));
  return themData;
}
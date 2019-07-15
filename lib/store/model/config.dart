import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeInfo {
  int colorInt;

  ThemeInfo({this.colorInt});
}

class ConfigModel extends ThemeInfo with ChangeNotifier {
  ThemeInfo _themeInfo = ThemeInfo(colorInt: Colors.red.value);

  int get colorInt => _themeInfo.colorInt;

  int getThemeColor() {
    /// 获取SP中theme的值
    return SpUtil.getInt('config_theme_color', defValue: colorInt);
  }

  Future<void> setTheme(colorInt) async {
    /// SP保存theme值
    SpUtil.putInt('config_theme_color', colorInt);

    _themeInfo.colorInt = colorInt;

    notifyListeners();
  }
}

List<int> themeColors = [
  Colors.red.value,
  Colors.blue.value,
  Colors.yellow.value,
  Colors.green.value,
  Colors.brown.value,
  Colors.orange.value,
  Colors.indigo.value,
  Colors.pink.value,
  Colors.black.value
];

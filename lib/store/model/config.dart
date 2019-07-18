import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeInfo {
  int colorInt;

  ThemeInfo({this.colorInt});
}

class LocalInfo {
  int localIndex;

  LocalInfo({this.localIndex});
}

class ConfigModel with ChangeNotifier {
  ThemeInfo _themeInfo = ThemeInfo(colorInt: Colors.red.value);
  LocalInfo _localInfo = LocalInfo(localIndex: 0);

  int get colorInt => _themeInfo.colorInt;

  int get localIndex => _localInfo.localIndex;

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

  int getLocal() {
    return SpUtil.getInt('config_local', defValue: localIndex);
  }

  Future<void> setLocal(localIndex) async {
    /// SP保存theme值
    SpUtil.putInt('config_local', localIndex);

    _localInfo.localIndex = localIndex;

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

/// 枚举: 支持的语言种类
enum SupportLocale {
  FOLLOW_SYSTEM,
  SIMPLIFIED_CHINESE,
  TRADITIONAL_CHINESE_TW,
  TRADITIONAL_CHINESE_HK,
  ENGLISH
}

/// SupportLocale -> locale
Map<SupportLocale, Locale> mapLocales = {
  SupportLocale.FOLLOW_SYSTEM: null,
  SupportLocale.SIMPLIFIED_CHINESE: Locale("zh", "CN"),
  SupportLocale.TRADITIONAL_CHINESE_TW: Locale("zh", "TW"),
  SupportLocale.TRADITIONAL_CHINESE_HK: Locale("zh", "HK"),
  SupportLocale.ENGLISH: Locale("en", "")
};

/// SupportLocale 对应的含义
Map<SupportLocale, String> get mapSupportLocale => {
  SupportLocale.FOLLOW_SYSTEM: "跟随系统",
  SupportLocale.SIMPLIFIED_CHINESE: "简体中文",
  SupportLocale.TRADITIONAL_CHINESE_TW: "繁體中文(臺灣)",
  SupportLocale.TRADITIONAL_CHINESE_HK: "繁體中文(香港)",
  SupportLocale.ENGLISH: "English"
};

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants.dart';
import 'generated/i18n.dart';
import 'page/home_page.dart';
import 'store/index.dart';
import 'store/model/config.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('根部重建: $context');

    return Store.init(
        context: context,
        child: Store.connect<ConfigModel>(builder:
            (BuildContext context, ConfigModel snapshot, Widget child) {
          return MaterialApp(
            title: Constants.appName,
            theme: snapshot.getTheme()
                ? Constants.darkTheme
                : Constants.lightTheme,
            home: Builder(builder: (context) {
              Store.widgetCtx = context;
              print('widgetCtx: $context');

              return MyHomePage(title: 'Provider Demo');
            }),

            /// localizationsDelegates 列表中的元素时生成本地化集合的工厂
            localizationsDelegates: [
              // 为Material Components库提供本地化的字符串和其他值
              GlobalMaterialLocalizations.delegate,

              // 定义widget默认的文本方向，从左往右或从右往左
              GlobalWidgetsLocalizations.delegate,

              S.delegate,
            ],

            ///
            supportedLocales: S.delegate.supportedLocales,

            ///
            locale: mapLocales[SupportLocale.values[snapshot.getLocal()]],

            /// 不存对应locale时，默认取值Locale('zh', 'CN')
            localeResolutionCallback:
                S.delegate.resolution(fallback: const Locale('zh', 'CN')),
          );
        }));
  }
}

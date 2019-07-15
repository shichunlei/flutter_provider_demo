import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

import 'page/home_page.dart';
import 'store/index.dart';
import 'store/model/config.dart';

void main() async {
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('根部重建: $context');

    return Store.init(
        context: context,
        child: Store.connect<ConfigModel>(builder: (context, snapshot, child) {
          return MaterialApp(
            title: 'Provider Demo',
            theme: getThemeData(snapshot.getThemeColor()),
            home: Builder(builder: (context) {
              Store.widgetCtx = context;
              print('widgetCtx: $context');

              return MyHomePage(title: 'Provider Demo Home Page');
            }),
          );
        }));
  }
}

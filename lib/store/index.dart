import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/config.dart';
import 'model/counter.dart';
import 'model/user.dart';

class Store {
  static BuildContext context;
  static BuildContext widgetCtx;

  //  初始化
  static init({BuildContext context, child}) {
    /// 返回多个状态
    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (_) => CounterModel()),
      ChangeNotifierProvider(builder: (_) => UserModel()),
      ChangeNotifierProvider(builder: (_) => ConfigModel())
    ], child: child);
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(BuildContext context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>(
      {Function(BuildContext context, T value, Widget child) builder,
      Widget child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}

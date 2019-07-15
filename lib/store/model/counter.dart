import 'package:flutter/foundation.dart';

class CounterInfo {
  int count;

  CounterInfo({this.count});
}

class CounterModel extends CounterInfo with ChangeNotifier {
  CounterInfo _counterInfo = CounterInfo(count: 0);

  int get count => _counterInfo.count;

  void increment() {
    _counterInfo.count++;
    notifyListeners();
  }

  void decrement() {
    _counterInfo.count--;
    notifyListeners();
  }
}

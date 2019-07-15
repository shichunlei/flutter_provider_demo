import 'package:flutter/foundation.dart';

class UserInfo {
  String name;

  UserInfo({this.name});
}

class UserModel extends UserInfo with ChangeNotifier {
  UserInfo _userInfo = UserInfo(name: '咕噜猫不吃猫粮不吃鱼');

  String get name => _userInfo.name;

  void setName(name) {
    _userInfo.name = name;
    notifyListeners();
  }
}

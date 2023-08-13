import 'package:flutter/cupertino.dart';
import '../model/User.dart';

class UserProvide with ChangeNotifier {
  late User user;

  User? get info => user;

  setUser(user) {
    user = User.fromJson(user);
    notifyListeners();
  }
}

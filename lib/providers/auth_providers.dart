import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/model/my_user.dart';

class AuthProviders extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}

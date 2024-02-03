import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/utils/commonWidgets.dart';

final loginController =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  String _userName = '';
  void updateTextField(String value) {
    _userName = value;
    notifyListeners();
  }

  void startGame() {
    if (_userName.length < 5) {
      showToast('Name must have atleast 5 characters');
    }
  }

  String get userName => _userName;
}

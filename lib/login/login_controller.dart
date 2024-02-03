import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/home/home_controller.dart';
import 'package:luckysecondsdown/utils/commonWidgets.dart';
import 'package:luckysecondsdown/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

final loginController =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  String _userName = '';
  void updateTextField(String value) {
    _userName = value;
    notifyListeners();
  }

  void startGame(BuildContext context, WidgetRef ref) async {
    if (_userName.length < 5) {
      _userName = '';
      notifyListeners();
      showToast('Name must have atleast 5 characters');
    } else {
      ref.read(homeController).resetValues();

      Navigator.of(context).pushNamed(homeRoute);
    }
  }

  // future implementation of storing score in
  storeToDatabase() async {
    await Hive.initFlutter();
    await Hive.openBox('scoreBoard');
    final notificationsDb = Hive.box('scoreBoard');
    String key = "scoreBoard";
    String targetName = _userName;

    if (notificationsDb.containsKey(key)) {
      List currentData = notificationsDb.get(key);

      int index = currentData.indexWhere((obj) => obj['name'] == targetName);

      if (index != -1) {
        return;
      } else {
        currentData.add({'name': targetName, 'attempts': 0, 'score': 0});

        notificationsDb.put(key, currentData);
      }
    } else {
      notificationsDb.put(key, [
        {'name': targetName, 'attempts': 0, 'score': 0}
      ]);
    }
  }

  String get userName => _userName;
}

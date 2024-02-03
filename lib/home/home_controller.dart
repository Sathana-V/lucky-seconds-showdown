import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:luckysecondsdown/home/home_page.dart';
import 'package:luckysecondsdown/login/login_controller.dart';
import 'package:luckysecondsdown/utils/commonWidgets.dart';

final homeController =
    ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  int numberOfAttempts = 0;
  int successfulAttemptCount = 0;
  int currentSecond = 0;
  int randomNumber = 0;
  int counter = 5;
  late Timer timer;
  bool isPaused = false;
  bool isTimerSet = false;
  late BuildContext contextValue;
  late WidgetRef refvalue;
  void setBuildContext(BuildContext context, WidgetRef ref) {
    contextValue = context;
    refvalue = ref;
    notifyListeners();
  }

  void checkLuck() {
    attemptMade();
    getCurrentSecond();
    getRandomNumber();
    checkAttemptStatus();
  }

  void startTimer() {
    isTimerSet = true;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!isPaused) {
        if (counter == 0) {
          checkLuck();
          showTimerDialogBox(contextValue, refvalue);
        } else {
          counter -= 1;
        }

        notifyListeners();
      }
    });
  }

  void pauseTimer() {
    // Pause the timer
    if (timer.isActive) {
      timer.cancel();
      isPaused = true;
      notifyListeners();
    }
  }

  void resumeTimer(BuildContext context, WidgetRef ref,
      [bool isCompletedFlow = false]) {
    // Resume the timer
    if (!timer.isActive) {
      if (!isCompletedFlow) {
        counter = 5;
      }

      timer.cancel();
      resetValues();
    }
    startTimer();
    isPaused = false;
  }

  void resetValues() {
    isPaused = false;
    counter = 5;
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void attemptMade() {
    numberOfAttempts += 1;
    notifyListeners();
  }

// future implementation
  void getScoreFromDb() async {
    String targetName = refvalue.read(loginController).userName;
    await Hive.initFlutter();
    await Hive.openBox('scoreBoard');
    final notificationsDb = Hive.box('scoreBoard');
    String key = "scoreBoard";
    if (notificationsDb.containsKey(key)) {
      List currentData = notificationsDb.get(key);

      int index = currentData.indexWhere((obj) => obj['name'] == targetName);
      if (index != -1) {
        numberOfAttempts = currentData[index]['attempts'];
        successfulAttemptCount = currentData[index]['score'];
        notifyListeners();
      }
    }
  }

  // future implementation
  void updateDatabase() async {
    String targetName = refvalue.read(loginController).userName;
    await Hive.initFlutter();
    await Hive.openBox('scoreBoard');
    final notificationsDb = Hive.box('scoreBoard');
    String key = "scoreBoard";
    if (notificationsDb.containsKey(key)) {
      List<Map<String, dynamic>> currentData = notificationsDb.get(key);

      int index = currentData.indexWhere((obj) => obj['name'] == targetName);

      if (index != -1) {
        currentData.add({
          'name': targetName,
          'attempts': numberOfAttempts,
          'score': successfulAttemptCount
        });
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

  void checkAttemptStatus() {
    pauseTimer();
    if (currentSecond == randomNumber) {
      successfulAttemptCount = successfulAttemptCount + 1;
      showStatusOfAttempt(contextValue, refvalue, false);
    } else {
      showStatusOfAttempt(contextValue, refvalue, true);
    }
    updateDatabase();
  }

  void getCurrentSecond() {
    currentSecond = DateTime.now().second;
    notifyListeners();
  }

  void getRandomNumber() {
    currentSecond = DateTime.now().second;
    Random random = Random();
    randomNumber = random.nextInt(60);
    notifyListeners();
  }
}

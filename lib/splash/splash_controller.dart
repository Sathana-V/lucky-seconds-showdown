import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/home/home_controller.dart';

import '../utils/constants.dart';

final splashController =
    ChangeNotifierProvider<SplashProvider>((ref) => SplashProvider());

class SplashProvider extends ChangeNotifier {
  late Timer timer;
  bool checked = true;
  Future<bool> loadHomePage(BuildContext context, WidgetRef ref) async {
    _init(context, ref);
    return Future.value(true);
  }

  _init(BuildContext context, WidgetRef ref) {
    Timer(const Duration(milliseconds: 3000), () async {
      Navigator.of(context).pushNamed(loginRoute);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:luckysecondsdown/utils/commonWidgets.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// app details
const appTitle = 'Lucky Seconds Showdown';

const splashRoute = '/';
const otpRoute = '/login';
const loginRoute = '/scanOrLogin';
const homeRoute = '/home';

// asset paths
const playAnimation = 'assets/animations/game.gif';
const appIcon = 'assets/icon.png';
const playButton = 'assets/background/playButton.png';
const inputField = 'assets/background/input.png';
const loginBg = 'assets/background/login-bg.png';

//common widgets
AppDetails appDetails = AppDetails();
Widget appNameWidget = appDetails.appNameWidget();

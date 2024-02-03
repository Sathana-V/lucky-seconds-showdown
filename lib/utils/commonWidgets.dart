import 'package:flutter/material.dart';
import 'package:luckysecondsdown/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppDetails {
  Widget appNameWidget() {
    return Text(
      appTitle.toUpperCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color.fromARGB(255, 213, 213, 213),
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
    );
  }
}

/// Function to display a toast with customizable parameters.
///
/// 1. [message]: The message to be displayed in the toast.
/// 2. [textColor]: The text color of the message in the toast.

showToast(String message, [String type = 'error']) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: type == 'success' ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

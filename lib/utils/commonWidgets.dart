import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/home/home_controller.dart';
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

class LuckySecondsWidgets {
  Widget luckyContainer(BuildContext context, Widget widget) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 0, 0, 0), Colors.black87],
          ),
        ),
        child: widget);
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

showStatusOfAttempt(BuildContext context, WidgetRef ref, bool isError) async {
  String filePath = isError
      ? 'assets/background/failure.jpeg'
      : 'assets/background/success.png';
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          insetPadding: const EdgeInsets.all(8.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 200),
                Image.asset(
                  filePath,
                  height: 100,
                  width: 100,
                ),
                FittedBox(
                  child: Text(
                    softWrap: true,
                    isError
                        ? "Hard luck! Keep trying, you're bound to hit the jackpot."
                        : "Congratulations! You've earned a point. ",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        ref.read(homeController).resumeTimer(context, ref);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Center(
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

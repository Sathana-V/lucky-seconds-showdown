import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/home/home_controller.dart';
import 'package:luckysecondsdown/utils/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isTimerSet = ref.read(homeController).isTimerSet;
      if (!isTimerSet) {
        ref.read(homeController).startTimer();
      }
    });
    int successCount = ref.watch(homeController).successfulAttemptCount;
    int totalAttempts = ref.watch(homeController).numberOfAttempts;
    int counter = ref.watch(homeController).counter;
    bool isPaused = ref.watch(homeController).isPaused;
    double boxWidth = counter * 50.0;
    ref.read(homeController).setBuildContext(context, ref);
    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: Padding(
              padding: EdgeInsets.zero,
              child: luckySecondsWidgets.luckyContainer(
                  context,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              appTitle.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              maxRadius: 40,
                              child: Text(
                                counter.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 250,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 1, 51, 92),
                                  ),
                                ),
                                if (boxWidth != 0)
                                  Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: boxWidth,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                        ),
                                      ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Won',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      'assets/background/field3.png',
                                      width: 165,
                                    ),
                                    Positioned(
                                      top: 15,
                                      left: 45,
                                      child: Text(
                                        (successCount).toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Total Attempts',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      'assets/background/field3.png',
                                      width: 165,
                                    ),
                                    Positioned(
                                      top: 15,
                                      left: 45,
                                      child: Text(
                                        (totalAttempts).toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(homeController).checkLuck();
                              showTimerDialogBox(context, ref);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 3, 36, 38),
                              onPrimary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/background/tick.png',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Check',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                )
                              ]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/background/close.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (!isPaused)
                              GestureDetector(
                                onTap: () {
                                  ref.read(homeController).pauseTimer();
                                },
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/background/pause.png',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            if (isPaused)
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(homeController)
                                      .resumeTimer(context, ref, true);
                                },
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/background/resume.png',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            // ClipOval(
                            //   child: Image.asset(
                            //     'assets/background/settings.png',
                            //     width: 60,
                            //     height: 60,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  )))),
    );
  }
}

showTimerDialogBox(BuildContext context, WidgetRef ref) async {
  int currentSecond = ref.watch(homeController).currentSecond;
  int randomNumber = ref.watch(homeController).randomNumber;
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          insetPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.blue,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 200),
                const Text(
                  'Current Secondi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Stack(children: [
                  Image.asset('assets/background/field1.png'),
                  Positioned(
                      top: 30,
                      left: 100,
                      child: Text(
                        (currentSecond).toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ]),
                const Text(
                  'Random Number',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Stack(children: [
                  Image.asset('assets/background/field2.png'),
                  Positioned(
                      top: 30,
                      left: 100,
                      child: Text(
                        (randomNumber).toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ]),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
              ],
            ),
          ),
        );
      });
}

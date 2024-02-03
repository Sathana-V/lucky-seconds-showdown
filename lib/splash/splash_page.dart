import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/utils/constants.dart';

import 'splash_controller.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: Padding(
              padding: EdgeInsets.zero,
              child: FutureBuilder(
                future: ref.read(splashController).loadHomePage(context, ref),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {}
                  return Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        ClipOval(
                          child: Image.asset(
                            appIcon,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          (appTitle).toUpperCase(),
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
                        ),
                        Image.asset(
                          playAnimation,
                          height: 300,
                          width: 300,
                        ),
                      ],
                    )),
                  );
                },
              ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckysecondsdown/login/login_controller.dart';
import 'package:luckysecondsdown/utils/constants.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 0, 0, 0), Colors.black87],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: Column(
                  children: [
                    appNameWidget,
                    const SizedBox(
                      height: 40,
                    ),
                    Stack(children: [
                      Image.asset(loginBg),
                      const Positioned(
                        top: 140,
                        left: 60,
                        child: Text('Name :',
                            style: TextStyle(color: Colors.white)),
                      ),
                      Positioned(
                          top: 160,
                          left: 50,
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  inputField,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: TextFormField(
                                cursorColor: Theme.of(context).primaryColor,
                                maxLength: 20,
                                onChanged: (value) {
                                  ref
                                      .read(loginController)
                                      .updateTextField(value);
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          top: 240,
                          left: 60,
                          child: GestureDetector(
                              onTap: () {
                                ref.read(loginController).startGame();
                              },
                              child: Image.asset(playButton)))
                    ]),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

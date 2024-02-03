import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luckysecondsdown/home/home_page.dart';
import 'package:luckysecondsdown/login/login_page.dart';
import 'package:luckysecondsdown/splash/splash_page.dart';
import 'utils/constants.dart';

class LuckySeconds extends StatelessWidget {
  const LuckySeconds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Lucky Seconds Showdown',
      theme: lightTheme(context),
      initialRoute: splashRoute,
      routes: {
        splashRoute: (context) => const SplashPage(),
        loginRoute: (context) => const LoginPage(),
        homeRoute: (context) => const HomePage(),
      },
    );
  }
}

ThemeData lightTheme(context) => ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    textTheme:
        GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.copyWith(
              headlineSmall: TextStyle(color: Colors.grey[800]),
              titleLarge: TextStyle(color: Colors.grey[800]),
              bodyLarge: const TextStyle(color: Colors.black),
              bodySmall: const TextStyle(color: Colors.black),
              titleMedium: const TextStyle(color: Colors.black),
              titleSmall: TextStyle(color: Colors.grey[200]),
              bodyMedium: const TextStyle(color: Colors.black),
            )),
    canvasColor: const Color.fromARGB(255, 9, 9, 9),
    primaryColor: const Color.fromARGB(255, 9, 9, 9),
    focusColor: Colors.amber[800],
    cardColor: Colors.red.shade800,
    highlightColor: Colors.greenAccent,
    secondaryHeaderColor: Colors.cyan,
    hoverColor: Colors.blueGrey,
    indicatorColor: Colors.pinkAccent[400],
    shadowColor: Colors.lightGreen[400],
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.blueAccent[400]));

ThemeData darkTheme(context) => ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      textTheme:
          GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.copyWith(
                headlineSmall: const TextStyle(color: Colors.grey),
                titleLarge: const TextStyle(color: Colors.grey),
                bodyLarge: const TextStyle(color: Colors.grey),
                bodySmall: const TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.grey[400]),
                titleSmall: TextStyle(color: Colors.grey[200]),
                bodyMedium: const TextStyle(color: Colors.white),
              )),
      canvasColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 161, 0, 0),
      focusColor: Colors.amber[800],
      cardColor: Colors.red.shade800,
      highlightColor: Colors.blueGrey[400],
      secondaryHeaderColor: Colors.teal[800],
      hoverColor: Colors.blueGrey,
      indicatorColor: Colors.pinkAccent[400],
    );

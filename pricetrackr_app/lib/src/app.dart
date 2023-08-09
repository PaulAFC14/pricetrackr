import 'package:flutter/material.dart';
import 'package:pricetrackr_app/src/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceTrackr',
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: Color.fromARGB(255, 18, 167, 95),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        hintColor: Color.fromARGB(255, 30, 30, 30),
      ),
      darkTheme: ThemeData(),
      home: Splash_Screen(context),
    );
  }
}

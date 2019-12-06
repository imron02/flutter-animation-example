import 'package:flutter/material.dart';

import 'package:flutter_animation/screen/home/screen.dart';
import 'package:flutter_animation/screen/fade_in/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        FadeInScreen.routeName: (context) => FadeInScreen()
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/animated_list/screen.dart';
import 'package:flutter_animation/screen/animation_controller/screen.dart';
import 'package:flutter_animation/screen/chat/screen.dart';
import 'package:flutter_animation/screen/cooking/screen.dart';

import 'package:flutter_animation/screen/home/screen.dart';
import 'package:flutter_animation/screen/fade_in/screen.dart';
import 'package:flutter_animation/screen/shape_shifting/screen.dart';
import 'package:flutter_animation/screen/travel_cards/screen.dart';
import 'package:flutter_animation/utils/routes.dart';

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
      initialRoute: Routes.mainScreen,
      routes: {
        Routes.mainScreen: (context) => HomeScreen(),
        Routes.fadeInScreen: (context) => FadeInScreen(),
        Routes.shapeShiftingScreen: (context) => ShapeShiftingScreen(),
        Routes.animationScreen: (context) => AnimationScreen(),
        Routes.chatScreen: (context) => ChatScreen(),
        Routes.cookingScreen: (context) => CookingScreen(),
        Routes.listScreen: (context) => ListScreen(),
        Routes.travelCardScreen: (context) => TravelCardScreen()
      },
    );
  }
}
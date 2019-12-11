import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/cooking/screen.dart';

import 'package:flutter_animation/utils/colors.dart' as colors;
import 'package:flutter_animation/screen/fade_in/screen.dart';
import 'package:flutter_animation/screen/fade_in/arguments.dart';
import 'package:flutter_animation/screen/animation_controller/screen.dart';
import 'package:flutter_animation/screen/chat/screen.dart';
import 'package:flutter_animation/screen/shape_shifting/screen.dart';

Color randomColor() {
  return Color((Random().nextDouble() * 0xFFFFFFFF).toInt() << 0).withOpacity(0.9);
}

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  final List<Map> cardList = <Map>[
    {
      'routeName': FadeInScreen.routeName,
      'argument': FadeInArguments('Fade-in'),
      'title': 'Fade-in',
      'color': randomColor()
    },
    {
      'routeName': ShapeShiftingScreen.routeName,
      'argument': null,
      'title': 'Shape-shifting',
      'color': randomColor()
    },
    {
      'routeName': AnimationScreen.routeName,
      'argument': null,
      'title': 'AnimationController',
      'color': randomColor()
    },
    {
      'routeName': ChatScreen.routeName,
      'argument': null,
      'title': 'Chat-animation',
      'color': randomColor()
    },
    {
      'routeName': CookingScreen.routeName,
      'argument': null,
      'title': 'Cooking Screen',
      'color': randomColor()
    }
  ];
  final List<Widget> gridList = [];

  void buildCardList(BuildContext context) {
    cardList.forEach((item) {
      gridList.add(
        Hero(
          tag: item['title'],
          child: Card(
            child: InkWell(
              onTap: () => _navigate(item, context),
              child: Center(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black26,
                        offset: Offset(5, 10),
                      )
                    ],
                  ),
                ),
              ),
            ),
            color: item['color'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
        ),
      );
    });
  }

  void _navigate(Map item, BuildContext context) {
    if (item['argument'] != null) {
      Navigator.pushNamed(
        context,
        item['routeName'],
        arguments: item['argument'],
      );
    } else {
      Navigator.pushNamed(context, item['routeName']);
    }
  }

  @override
  Widget build(BuildContext context) {
    buildCardList(context);

    Container backgroundApp = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );

    Center card = Center(
      child: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: gridList,
        shrinkWrap: true,
      ),
    );

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            backgroundApp,
            card,
          ],
        ),
      ),
    );
  }
}

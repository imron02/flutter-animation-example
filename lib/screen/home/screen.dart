import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_animation/utils/colors.dart' as colors;
import 'package:flutter_animation/screen/fade_in/arguments.dart';
import 'package:flutter_animation/utils/routes.dart';

Color randomColor() {
  return Color((Random().nextDouble() * 0xFFFFFFFF).toInt() << 0)
      .withOpacity(0.9);
}

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  final List<Map> cardList = <Map>[
    {
      'routeName': Routes.fadeInScreen,
      'argument': FadeInArguments('Fade-in'),
      'title': 'Fade-in',
      'color': randomColor()
    },
    {
      'routeName': Routes.shapeShiftingScreen,
      'argument': null,
      'title': 'Shape-shifting',
      'color': randomColor()
    },
    {
      'routeName': Routes.animationScreen,
      'argument': null,
      'title': 'AnimationController',
      'color': randomColor()
    },
    {
      'routeName': Routes.chatScreen,
      'argument': null,
      'title': 'Chat-animation',
      'color': randomColor()
    },
    {
      'routeName': Routes.cookingScreen,
      'argument': null,
      'title': 'Cooking UI',
      'color': randomColor()
    },
    {
      'routeName': Routes.listScreen,
      'argument': null,
      'title': 'Animated List',
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

    Widget card = SingleChildScrollView(
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

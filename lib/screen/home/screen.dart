import 'package:flutter/material.dart';

import 'package:flutter_animation/utils/colors.dart' as colors;
import 'package:flutter_animation/screen/fade_in/screen.dart';
import 'package:flutter_animation/screen/fade_in/arguments.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  final List<Map> cardList = <Map>[
    {'index': 1, 'title': 'Fade-in', 'color': colors.mandysPink},
    {'index': 2, 'title': 'Shape-shifting', 'color': colors.deepBlush},
    {'index': 3, 'title': 'Animation 3', 'color': colors.moodyBlue},
    {'index': 4, 'title': 'Animation 4', 'color': colors.viking}
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
                child: Text(item['title']),
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
    switch (item['index']) {
      case 1:
        Navigator.pushNamed(
          context,
          FadeInScreen.routeName,
          arguments: FadeInArguments(item['title']),
        );
        break;
      default:
        break;
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

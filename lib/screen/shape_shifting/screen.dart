import 'dart:math';

import 'package:flutter/material.dart';

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class ShapeShiftingScreen extends StatefulWidget {
  @override
  _ShapeShiftingScreenState createState() => _ShapeShiftingScreenState();
}

class _ShapeShiftingScreenState extends State<ShapeShiftingScreen> {
  Color color;
  double borderRadius;
  double margin;

  @override
  void initState() {
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();

    super.initState();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape-shifting'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: AnimatedContainer(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                duration: Duration(seconds: 1),
                curve: Curves.easeInOutBack,
              ),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'change',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: change,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/cooking/attribute.screen.dart';

import 'package:flutter_animation/screen/cooking/model/food.dart';

class CookingScreen extends StatefulWidget {
  static const routeName = 'cooking-screen';

  @override
  _CookingScreenState createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen>
    with TickerProviderStateMixin {
  /// Plate animation
  AnimationController _controller;
  Animation<double> _antiClockRotationWiseAnimation;
  Animation<double> _clockWiseRotationAnimation;
  Tween<double> _antiClockWiseRotationTween;
  Tween<double> _clockWiseRotationTween;
  bool isClockWise = false;
  double rotationValue = 0.0;
  int currentIndex = 1;
  bool isBgBlack = false;
  double blackBgHeight = 0.0;

  /// Food page description
  AnimationController _textOpacityController;
  Animation<double> _textOpacityAnimation;
  AnimationController _textColorController;
  Animation<Color> _textColorAnimation;

  @override
  void initState() {
    super.initState();

    // Plate animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _clockWiseRotationTween = Tween<double>(end: 2 * pi);
    _clockWiseRotationAnimation = _clockWiseRotationTween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _antiClockWiseRotationTween = Tween<double>(end: -2 * pi);
    _antiClockRotationWiseAnimation = _antiClockWiseRotationTween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut)
        ..addListener(() {
          setState(() {
            rotationValue = isClockWise
                ? _clockWiseRotationAnimation.value
                : _antiClockRotationWiseAnimation.value;
          });
        }),
    );

    // Page description animation
    _textOpacityController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _textOpacityAnimation =
        Tween<double>(begin: 1, end: 0.0).animate(_textOpacityController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _changeFood();
              _textOpacityController.reverse();
            }
          });
    _textColorController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _textColorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_textColorController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textOpacityController.dispose();
    _textColorController.dispose();
    super.dispose();
  }

  void _onVerticalDragStart(DragStartDetails details) {}

  void _onVerticalDragEnd(DragEndDetails details) {
    rotationValue = 0.0;
    _antiClockWiseRotationTween.begin = rotationValue;
    _clockWiseRotationTween.begin = rotationValue;

    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
      _textOpacityController.forward(from: 0.0);

      // Change text color
      if (!isBgBlack) {
        _textColorController.forward(from: 0.0);
      } else {
        _textColorController.reverse();
      }

      isBgBlack = !isBgBlack;
      setState(() {
        isBgBlack = isBgBlack;
        blackBgHeight = isBgBlack ? MediaQuery.of(context).size.height : 0.0;
      });
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    isClockWise = details.delta.dy < 0;
  }

  void _changeFood() {
    setState(() {
      if (!isClockWise) {
        currentIndex =
            currentIndex < foodList.length - 1 ? currentIndex + 1 : 0;
      } else {
        currentIndex =
            currentIndex > 0 ? currentIndex - 1 : foodList.length - 1;
      }
    });
  }

  Widget _buildPlate() {
    return Container(
      child: Transform.translate(
        offset: Offset(80, 0.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Transform.rotate(
            angle: rotationValue,
            child: Image.asset(
              foodList[currentIndex].foodAssetsPath,
              width: 180,
              height: 250,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGestureDetection() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: MediaQuery.of(context).size.width / 2,
      right: 0.0,
      child: GestureDetector(
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragEnd: _onVerticalDragEnd,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildBlackBg() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        color: Color(0xFF384450),
        height: blackBgHeight,
      ),
    );
  }

  Widget _buildText() {
    return Positioned(
      top: 60,
      left: 32,
      right: 80,
      bottom: 0.0,
      child: ListView(
        children: <Widget>[
          Text(
            "DAILY COOKING QUEST",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              foodList[currentIndex].foodName,
              style: TextStyle(
                color: _textColorAnimation.value,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 60),
          AttributeScreen(
            text: foodList[currentIndex].cookingDifficulty,
            icon: Icons.hot_tub,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          AttributeScreen(
            text: foodList[currentIndex].cookingTime,
            icon: Icons.timer,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          AttributeScreen(
            text: foodList[currentIndex].foodEffect,
            icon: Icons.spa,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          AttributeScreen(
            text: foodList[currentIndex].foodType,
            icon: Icons.four_k,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          SizedBox(height: 50),
          Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              foodList[currentIndex].foodDescription,
              style: TextStyle(
                color: _textColorAnimation.value,
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isBgBlack
          ? AppBar(
              title: Text('Cook Menu'),
            )
          : null,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: Color(0xFFF1F1F3),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _buildBlackBg(),
                _buildText(),
                _buildPlate(),
                _buildGestureDetection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

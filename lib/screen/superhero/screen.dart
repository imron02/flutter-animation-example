import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/screen/superhero/detail.dart';
import 'package:flutter_animation/screen/superhero/models/Characters.dart';
import 'package:flutter_animation/screen/superhero/models/character_list.dart';
import 'package:flutter_animation/screen/superhero/widgets/card/widget.dart';
import 'package:flutter_animation/utils/hex_color.dart';

class SuperHeroScreen extends StatefulWidget {
  @override
  _SuperHeroScreenState createState() => _SuperHeroScreenState();
}

class _SuperHeroScreenState extends State<SuperHeroScreen>
    with TickerProviderStateMixin {
  Future<Characters> apiResponse;
  List<CharacterList> characters;
  int currentIndex = 0;

  Tween<double> _rotationTween;

  AnimationController _controller;
  Animation<Offset> _translationAnim;
  Animation<double> _rotationAnim;
  Animation<Offset> _moveAnim;
  Animation<double> _scaleAnim;
  Animation<double> _scaleCharacterAnim;
  Animation<Color> _characterColorAnim;

  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    apiResponse = loadCharacters();
    apiResponse.then((Characters apiResponse) {
      setState(() {
        characters = apiResponse.data.characters;
      });
    });

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _translationAnim =
        Tween<Offset>(begin: Offset(.0, .0), end: Offset(-100, 100.0))
            .animate(_controller)
              ..addListener(() {
                setState(() {});
              });
    _rotationTween = Tween<double>(begin: .0, end: 1);
    _rotationAnim = _rotationTween.animate(_controller);

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _moveAnim = Tween<Offset>(begin: Offset(.0, -.06), end: Offset(.0, .0))
        .animate(_curvedAnimation);
    _scaleAnim = Tween<double>(begin: .9, end: 1).animate(_curvedAnimation);
    _scaleCharacterAnim =
        Tween<double>(begin: .2, end: 1).animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Characters> loadCharacters() async {
    String jsonString =
        await rootBundle.loadString('assets/mock/characters.json');
    Map apiResponseMap = jsonDecode(jsonString);

    await Future.delayed(Duration(seconds: 1));
    return Characters.fromJson(apiResponseMap);
  }

  Widget _buildChild(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (characters == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      overflow: Overflow.visible,
      children: characters.reversed.map((CharacterList character) {
        if (characters.indexOf(character) <= 2) {
          return GestureDetector(
            onHorizontalDragEnd: _horizontalDragEnd,
            onVerticalDragEnd: (DragEndDetails details) {
              _verticalDragEnd(details, character);
            },
            child: Transform.translate(
              offset: _getFlickTransformOffset(characters.indexOf(character)),
              child: Transform.rotate(
                angle: _getFlickRotateOffset(characters.indexOf(character)),
                origin: Offset(0, size.height),
                child: FractionalTranslation(
                  translation:
                      _getStackedCardOffset(characters.indexOf(character)),
                  child: Transform.scale(
                    scale: _getStackedCardScale(characters.indexOf(character)),
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: HeroCard(
                        characterScaleFactor:
                            _getCharacterScale(characters.indexOf(character)),
                        character: character,
                        characterColor: _getCharacterColor(
                          characters.indexOf(character),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Container();
      }).toList(),
    );
  }

  Color _getCharacterColor(int cardIndex) {
    String colorString =
        "0xff${characters.elementAt(cardIndex).background}".replaceAll("#", "");
    int colorInt = int.parse(colorString);
    _characterColorAnim =
        ColorTween(begin: Colors.grey[200], end: Color(colorInt))
            .animate(_curvedAnimation);

    if (cardIndex == currentIndex) {
      return HexColor(characters.elementAt(cardIndex).background);
    } else if (cardIndex == currentIndex + 1) {
      return _characterColorAnim.value;
    } else {
      return Colors.grey[200];
    }
  }

  void _horizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity < 0) {
      _rotationTween.end = 1;

      _controller.forward().whenComplete(() {
        CharacterList character = characters.removeAt(0);
        setState(() {
          _controller.reset();
          characters.add(character);
        });
      });
    }

    if (details.primaryVelocity > 0) {
      _rotationTween.end = -1;

      _controller.forward().whenComplete(() {
        CharacterList character = characters.removeAt(0);
        setState(() {
          _controller.reset();
          characters.add(character);
        });
      });
    }
  }

  void _verticalDragEnd(DragEndDetails details, CharacterList character) {
    if (details.primaryVelocity < 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HeroDetail(character: character),
        ),
      );
    }
  }

  Offset _getFlickTransformOffset(int cardIndex) {
    if (cardIndex == currentIndex) {
      return _translationAnim.value;
    }

    return Offset(.0, .0);
  }

  double _getFlickRotateOffset(int cardIndex) {
    if (cardIndex == currentIndex) {
      return -math.pi * _rotationAnim.value;
    }

    return .0;
  }

  Offset _getStackedCardOffset(int cardIndex) {
    int diff = cardIndex - currentIndex;

    if (cardIndex == currentIndex + 1) {
      return _moveAnim.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(.0, -.06 * diff);
    } else {
      return Offset(.0, .0);
    }
  }

  double _getStackedCardScale(int cardIndex) {
    int diff = cardIndex - currentIndex;

    if (cardIndex == currentIndex) {
      return 1;
    } else if (cardIndex == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      return (1 - (0.123 * diff.abs()));
    }
  }

  double _getCharacterScale(int cardIndex) {
    if (cardIndex == currentIndex) {
      return 1;
    } else if (cardIndex == currentIndex + 1) {
      return _scaleCharacterAnim.value;
    } else {
      return 0.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Movies',
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 1,
              fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _buildChild(context),
    );
  }
}

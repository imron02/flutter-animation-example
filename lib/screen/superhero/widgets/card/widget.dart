import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/superhero/detail.dart';
import 'package:flutter_animation/screen/superhero/models/character_list.dart';

class HeroCard extends StatelessWidget {
  final CharacterList character;
  final Color characterColor;
  final double characterScaleFactor;

  HeroCard(
      {@required this.character,
      @required this.characterColor,
      @required this.characterScaleFactor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = TextTheme(
      display3: TextStyle(
        color: Colors.white,
        fontSize: 60,
        fontWeight: FontWeight.bold,
        height: 0.8,
      ),
      title: TextStyle(
        color: Colors.white,
      ),
    );

    return Stack(
      alignment: AlignmentDirectional.topStart,
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          height: size.height * 0.6,
          width: size.width,
          decoration: BoxDecoration(
            color: characterColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
        ),
        Positioned(
          top: -150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Transform.scale(
                scale: characterScaleFactor,
                child: Hero(
                  tag: character.url,
                  child: Image.asset(
                    character.url,
                    height: size.height * 0.5,
                    width: size.width,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width * .55,
                      child: Text(
                        character.name.toLowerCase(),
                        style: textTheme.display3,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      character.actor.toLowerCase(),
                      style: textTheme.title,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HeroDetail(character: character),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Know more',
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: Colors.yellow,
                                  letterSpacing: 2,
                                ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

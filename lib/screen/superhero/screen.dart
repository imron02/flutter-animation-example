import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/screen/superhero/models/Characters.dart';
import 'package:flutter_animation/screen/superhero/models/character_list.dart';
import 'package:flutter_animation/screen/superhero/widgets/card/widget.dart';
import 'package:flutter_animation/utils/hex_color.dart';

class SuperHeroScreen extends StatefulWidget {
  @override
  _SuperHeroScreenState createState() => _SuperHeroScreenState();
}

class _SuperHeroScreenState extends State<SuperHeroScreen> {
  Future<Characters> apiResponse;
  List<CharacterList> characters;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    apiResponse = loadCharacters();
    apiResponse.then((Characters apiResponse) {
      setState(() {
        characters = apiResponse.data.characters;
      });
    });
  }

  Future<Characters> loadCharacters() async {
    String jsonString =
        await rootBundle.loadString('assets/mock/characters.json');
    Map apiResponseMap = jsonDecode(jsonString);

    await Future.delayed(Duration(seconds: 1));
    return Characters.fromJson(apiResponseMap);
  }

  Widget _buildChild(BuildContext context) {
    if (characters == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      overflow: Overflow.visible,
      children: characters.reversed.map((CharacterList character) {
        if (characters.indexOf(character) <= 2) {
          return Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: HeroCard(
              character: character,
              characterColor: _getCharacterColor(
                characters.indexOf(character),
              ),
            ),
          );
        }

        return Container();
      }).toList(),
    );
  }

  Color _getCharacterColor(int cardIndex) {
    if (cardIndex == currentIndex) {
      return HexColor(characters.elementAt(cardIndex).background);
    } else {
      return Colors.grey[200];
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

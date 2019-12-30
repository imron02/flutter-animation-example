import 'package:flutter_animation/screen/superhero/models/character_list.dart';

class Data {
  List<CharacterList> characters;

  Data(this.characters);

  Data.fromJson(Map<String, dynamic> json) {
    characters = (json['characters'] as List)
        .map((e) => CharacterList.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() => {'characters': characters};
}

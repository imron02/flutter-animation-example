class CharacterList {
  final String name;
  final String url;
  final String actor;
  final String background;
  final String description;

  CharacterList(
      this.name, this.url, this.actor, this.background, this.description);

  CharacterList.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        actor = json['actor'],
        background = json['background'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'actor': actor,
        'background': background,
        'description': description,
      };
}

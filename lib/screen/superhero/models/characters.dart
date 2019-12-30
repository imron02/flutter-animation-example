import 'package:flutter_animation/screen/superhero/models/data.dart';

class Characters {
  final bool success;
  final String message;
  Data data;

  Characters(this.success, this.message);

  Characters.fromJson(Map<String, dynamic> json) : 
  success = json['success'],
  message = json['message'],
  data = Data.fromJson(json['data'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data
  };
}
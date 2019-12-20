import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/travel_cards/models/hotel.dart';

class City {
  final String name;
  final String title;
  final String description;
  final Color color;
  final List<Hotel> hotels;

  City({
    this.name,
    this.title,
    this.description,
    this.color,
    this.hotels
  });
}
import 'package:flutter/material.dart';

abstract class Helper {
  static screenWidth(context) => MediaQuery.of(context).size.width;
  static screenHeight(context) => MediaQuery.of(context).size.height;
}
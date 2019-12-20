import 'package:flutter/material.dart';
import 'dart:math' as math;

class Rotation3d extends StatelessWidget {
  static const double degress2radians = math.pi / 180;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  Rotation3d(
      {Key key,
      @required this.child,
      this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationX * degress2radians)
        ..rotateY(rotationY * degress2radians)
        ..rotateZ(rotationZ * degress2radians),
        child: child,
    );
  }
}

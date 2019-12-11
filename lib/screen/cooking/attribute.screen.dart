import 'package:flutter/material.dart';

class AttributeScreen extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double opacity;

  AttributeScreen(
      {@required this.text,
      @required this.icon,
      @required this.color,
      @required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.green,
          ),
          Opacity(
            opacity: opacity,
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

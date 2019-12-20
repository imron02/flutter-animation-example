import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/travel_cards/models/city.dart';

class TravelCardRenderer extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final City city;
  final double offset;

  TravelCardRenderer(this.offset,
      {Key key,
      this.cardWidth = 250,
      this.cardHeight = 160,
      @required this.city})
      : super(key: key);

  Widget _buildCityImage() {
    double maxParallax = 30;
    double globalOffset = offset * maxParallax * 2;
    double cardPadding = 28;
    double containerWidth = cardWidth - cardPadding;

    return Container(
      width: containerWidth,
      height: cardHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildPositionedLayer(
            'assets/images/${city.name}/${city.name}-Back.png',
            containerWidth * .8,
            maxParallax * 1,
            globalOffset,
          ),
          _buildPositionedLayer(
            'assets/images/${city.name}/${city.name}-Middle.png',
            containerWidth * .9,
            maxParallax * .6,
            globalOffset,
          ),
          _buildPositionedLayer(
            'assets/images/${city.name}/${city.name}-Front.png',
            containerWidth * .9,
            maxParallax,
            globalOffset,
          ),
        ],
      ),
    );
  }

  Widget _buildPositionedLayer(
      String path, double width, double maxOffset, double globalOffset) {
    double cardPadding = 24;
    double layerWidth = cardWidth - cardPadding;

    return Positioned(
      left:
          ((layerWidth * .5) - (width / 2) - offset * maxOffset) + globalOffset,
      bottom: cardHeight * .45,
      child: Image.asset(
        path,
        width: width,
      ),
    );
  }

  Widget _buildCityData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: cardHeight * .57,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            city.title,
            style: TextStyle(height: 1, color: Color(0xFF1a1a1a), fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            city.description,
            style: TextStyle(
              color: Color(0xFF666666),
              height: 1.5,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        FlatButton(
          child: Text(
            'Learn More'.toUpperCase(),
            style: TextStyle(
              color: Color(0xFFa6998b),
              fontSize: 10,
              height: 1,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
          onPressed: null,
        ),
        SizedBox(height: 8)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(top: 8),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: city.color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4 * offset.abs()),
                BoxShadow(
                    color: Colors.black12, blurRadius: 10 + 6 * offset.abs()),
              ],
            ),
          ),
          Positioned(
            top: -15,
            child: _buildCityImage(),
          ),
          _buildCityData(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/travel_cards/models/city.dart';
import 'package:flutter_animation/screen/travel_cards/widgets/card/widget.dart';
import 'package:flutter_animation/screen/travel_cards/widgets/rotation/widget.dart';

class TravelCardList extends StatefulWidget {
  final List<City> cities;
  final Function onCityChange;

  const TravelCardList({Key key, @required this.cities, this.onCityChange})
      : super(key: key);

  @override
  _TravelCardListState createState() => _TravelCardListState();
}

class _TravelCardListState extends State<TravelCardList> with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;
  PageController _pageController;

  double _cardWidth = 160;
  double _cardHeight = 200;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController _tweenController;
  Tween<double> _tween;
  Animation<double> _tweenAnim;

  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _startOffsetTweenToZero() {
    int tweenTime = 1000;
    if (_tweenController == null) {
      _tweenController = AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween.animate(new CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut))
        ..addListener(() {
          _setOffset(_tweenAnim.value);
        });
    }

    _tween.begin = _normalizedOffset;
    _tween.end = 0;
    _tweenController.reset();
    _tweenController.forward();
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx + scrollFactor);

        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      widget.onCityChange(widget.cities.elementAt(_pageController.page.round() % widget.cities.length));
    }

    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;

      if (_tween != null) {
        _tweenController.stop();
      }
    }

    return true;
  }

  Widget _buildItemRenderer(int itemIndex) {
    return Container(
      child: Rotation3d(
        rotationY: _normalizedOffset * _maxRotation,
        child: TravelCardRenderer(
          _normalizedOffset,
          cardWidth: _cardWidth,
          cardHeight: _cardHeight,
          city: widget.cities[itemIndex % widget.cities.length],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _cardHeight = (size.height * .48).clamp(300.0, 400.0);
    _cardWidth = _cardHeight * .8;
    _pageController = PageController(initialPage: 1, viewportFraction: _cardWidth / size.width);

    Widget listContent = Container(
      height: _cardHeight,
      child: PageView.builder(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => _buildItemRenderer(i),
      )
    );

    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }
}

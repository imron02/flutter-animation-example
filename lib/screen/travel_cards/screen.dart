import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/travel_cards/mock/list.dart';
import 'package:flutter_animation/screen/travel_cards/models/city.dart';
import 'package:flutter_animation/screen/travel_cards/widgets/card_list/widget.dart';
import 'package:flutter_animation/screen/travel_cards/widgets/hotel_list/widget.dart';

class TravelCardScreen extends StatefulWidget {
  @override
  _TravelCardScreenState createState() => _TravelCardScreenState();
}

class _TravelCardScreenState extends State<TravelCardScreen> {
  List<City> _cityList;
  City _currentCity;

  @override
  void initState() {
    super.initState();
    var data = Data();
    _cityList = data.getCities();
    _currentCity = _cityList[1];
  }

  void _handleCityChange(City city) {
    setState(() {
      this._currentCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Cards'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Where are you going next?',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFF0e0e0e),
                    fontSize: 36,
                    height: 1,
                    fontFamily: 'DMSerifDisplay',
                  ),
                ),
              ),
              TravelCardList(
                cities: _cityList,
                onCityChange: _handleCityChange,
              ),
              HotelList(_currentCity.hotels),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

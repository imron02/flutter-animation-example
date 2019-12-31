import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/travel_cards/models/hotel.dart';

class HotelList extends StatefulWidget {
  final List<Hotel> hotels;

  HotelList(this.hotels);

  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList>
    with SingleTickerProviderStateMixin {
  AnimationController _anim;
  List<Hotel> _oldHotels;

  @override
  void initState() {
    _anim =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _anim.addListener(() => setState(() {}));
    super.initState();
  }

  List<Widget> _buildHotelData(List<Hotel> hotels) {
    List<Widget> hotelRow = [];

    for (Hotel hotel in hotels) {
      hotelRow.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                hotel.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3),
              Row(
                children: <Widget>[
                  _buildStars(hotel.rate.toInt()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      hotel.rate.toString(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Text(
                    '\$${hotel.price}',
                    style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 13,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ));
    }

    return hotelRow;
  }

  Widget _buildStars(int count) {
    List<Widget> stars = [];

    for (int i = 0; i < count; i++) {
      stars.add(Icon(Icons.star, color: Color(0xFFfeda7d)));
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_oldHotels != widget.hotels) {
      _anim.forward(from: 0);
    }
    _oldHotels = widget.hotels;

    return Opacity(
      opacity: _anim.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18 * 1.5, vertical: 10),
        child: Container(
          width: 400,
          height: size.height * .30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hotels'.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildHotelData(widget.hotels),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

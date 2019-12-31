import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/superhero/models/character_list.dart';

class HeroDetail extends StatefulWidget {
  final CharacterList character;

  HeroDetail({Key key, @required this.character}) : super(key: key);

  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> with TickerProviderStateMixin {
  int _bgColor;
  Color _textColor = Colors.white;

  Animation<Offset> _animation;
  Animation<Offset> _titleAnimation;
  Animation<Offset> _detailAnimation;
  CurvedAnimation _curvedAnimation;
  AnimationController _backgroundAnimationController;
  AnimationController _titleAnimationController;
  AnimationController _detailAnimationController;

  @override
  void initState() {
    super.initState();
    String colorString =
        '0xff${widget.character.background}'.replaceAll('#', '');
    _bgColor = int.parse(colorString);

    _backgroundAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1.0))
        .animate(_backgroundAnimationController);

    _titleAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(
        parent: _titleAnimationController, curve: Curves.easeOutBack);
    _titleAnimation = Tween<Offset>(begin: Offset(0, .7), end: Offset(0, .0))
        .animate(_curvedAnimation);

    _detailAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _detailAnimation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0, .0))
        .animate(_curvedAnimation);

    // Start animation
    _titleAnimationController.forward().whenComplete(() {
      setState(() {
        _textColor = Colors.black;
      });

      _backgroundAnimationController.forward().whenComplete(() {
        _detailAnimationController.forward();
      });
    });
  }

  Future<bool> _onWillPop() {
    return _reverseAllAnimationAndPop();
  }

  Future<bool> _reverseAllAnimationAndPop() {
    return _detailAnimationController.reverse().whenComplete(() {
      _backgroundAnimationController.reverse().whenComplete(() {
        _titleAnimationController.reverse().whenComplete(() {
          Navigator.of(context).pop();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle display3 =
        Theme.of(context).textTheme.display3.copyWith(color: _textColor);
    TextStyle title =
        Theme.of(context).textTheme.title.copyWith(color: _textColor);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SlideTransition(
                position: _animation,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      stops: [0.7, 1.0],
                      colors: [Color(_bgColor), Colors.white70],
                    ),
                  ),
                  width: size.width,
                  height: size.height,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 34, left: 24, right: 34),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Hero(
                          tag: widget.character.url,
                          child: Image.asset(
                            widget.character.url,
                            height: size.height * 0.5,
                            width: size.width,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                          onPressed: () {
                            _reverseAllAnimationAndPop();
                          },
                        )
                      ],
                    ),
                    SlideTransition(
                      position: _titleAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width * .55,
                            child: Text(
                              widget.character.name.toLowerCase(),
                              style: display3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.character.actor.toLowerCase(),
                                style: title,
                              ),
                              Image.asset(
                                'assets/images/marvelLogo.png',
                                width: 60,
                                height: 50,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SlideTransition(
                      position: _detailAnimation,
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.character.description,
                            style: TextStyle(color: Colors.grey),
                            maxLines: 3,
                          ),
                          Divider(),
                          Text('Movies', style: title),
                          Container(
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 10,
                              children: List.generate(2, (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color: Colors.redAccent,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/A${index + 1}.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_animation/screen/fade_in/arguments.dart';

const owl_url =
    'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInScreen extends StatefulWidget {
  static const routeName = '/fadein';

  @override
  _FadeInScreenState createState() => _FadeInScreenState();
}

class _FadeInScreenState extends State<FadeInScreen> {
  double opacityLevel = 0.0;

  @override
  Widget build(BuildContext context) {
    final FadeInArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.tagHero),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: args.tagHero,
              child: FadeInImage.memoryNetwork(
                height: 350,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: owl_url,
              ),
            ),
            MaterialButton(
              child: Text('Show details'),
              onPressed: () => setState(() {
                opacityLevel = 1;
              }),
            ),
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: 2),
              child: Column(
                children: <Widget>[
                  Text('Type: Owl'),
                  Text('Age: 39'),
                  Text('Employment: None'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

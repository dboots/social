import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utils {
  static Widget getBackButton(Function callback) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
              iconSize: 48.0,
              padding: const EdgeInsets.all(0.0),
              icon:
                  Icon(FontAwesomeIcons.timesCircle, color: Color(0xFFCCCCCC)),
              onPressed: callback)
        ]);
  }

  static tabBack(PageController controller, num index) {
    controller.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  static Widget getSpacer(double top) {
    return Container(margin: EdgeInsets.only(top: top), child: null);
  }

  static Widget getBranding() {
    return Center(
        child: Container(
            child: Column(children: <Widget>[
      Text('Social',
          style: TextStyle(
              fontFamily: 'Watermelon',
              fontSize: 80.0,
              color: Color(0xFF00A0BE))),
      Text('LIFE IS BETTER TOGETHER',
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 12.0,
              color: Color(0xFF525252),
              letterSpacing: 2.0))
    ])));
  }

  static Widget getBackground() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: AspectRatio(
            aspectRatio: (2 / 3),
            child: Opacity(
                opacity: 1.0,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/social-marketing-2.png'),
                            fit: BoxFit.cover))))));
  }
}

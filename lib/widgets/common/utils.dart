import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utils {
    static Widget getBackButton(PageController controller) {
        return new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
                new IconButton(
                    iconSize: 48.0,
                    padding: const EdgeInsets.all(0.0),
                    icon: new Icon(
                        FontAwesomeIcons.timesCircleO,
                        color: new Color(0xFFCCCCCC)
                    ), 
                    onPressed: () {
                        controller.animateToPage(0, duration: new Duration(milliseconds: 250), curve: Curves.easeIn);
                    }
                )
            ]
        );
    }

    static Widget getSpacer(double top) {
        return new Container(
            margin: new EdgeInsets.only(top: top),
            child: null
        );
    }

    static Widget getBranding() {
        return new Center(
            child: new Container(
                child: new Column(
                    children: <Widget>[
                        new Text(
                            'Social',
                            style: new TextStyle(
                                fontFamily: 'Watermelon',
                                fontSize: 80.0,
                                color: new Color(0xFF00A0BE)
                            )
                        ),
                        new Text(
                            'LIFE IS BETTER TOGETHER',
                            style: new TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 12.0,
                                color: new Color(0xFF525252),
                                letterSpacing: 2.0
                            )
                        )
                    ]
                )
            )
        );
    }

    static Widget getBackground() {
        return new Container(
            alignment: Alignment.bottomCenter,
            child: new AspectRatio(
                aspectRatio: (2/3),
                child: new Opacity(
                    opacity: 0.8,
                    child: new Container(
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: new AssetImage('images/social-marketing-2.png'),
                                fit: BoxFit.cover
                            )
                        )
                    )
                )
            )
        );
    }
}
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:social/widgets/common/utils.dart';
import 'package:social/widgets/login.dart';

class LandingPage extends StatefulWidget {
    LandingPage() : super();
    
    @override
    _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
    BuildContext _buildContext = null;
    PageController _controller = new PageController();

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            resizeToAvoidBottomPadding: false,
            body: new Stack(
                children: <Widget>[
                    Utils.getBackground(),
                    new PageView(
                        physics: new NeverScrollableScrollPhysics(),
                        controller: this._controller,
                        children: <Widget>[
                            new Column(
                                children: <Widget>[
                                    Utils.getSpacer(50.0),
                                    Utils.getBranding(),
                                    Utils.getSpacer(75.0),
                                    _getBody()
                                ]
                            ),
                            new Column(
                                children: <Widget>[
                                    Utils.getSpacer(50.0),
                                    new FractionallySizedBox(
                                        widthFactor: 0.8,
                                        child: Utils.getBackButton(this._controller)
                                    ),
                                    Utils.getSpacer(100.0),
                                    new LoginPage()
                                ]
                            )
                        ]
                    )        
                ]
            )
        );
    }

    _getBody() {
        return new Column(
            children: <Widget>[
                _getButtons()
            ]
        );
    }

    _getButtons() {
        return new Column(
            children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: new FractionallySizedBox(
                        widthFactor: 0.8,
                        child: new FlatButton(
                            onPressed: () {
                                _controller.animateToPage(1, duration: new Duration(milliseconds: 250), curve: Curves.easeIn);
                            },
                            color: new Color(0xFF00A0BE),
                            textColor: new Color(0xFFFFFFFF),
                            child: new Text('LOGIN'),
                        )
                    )
                ),
                new Text(
                    'SIGN UP',
                    style: new TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 12.0,
                        color: new Color(0xFF525252),
                        letterSpacing: 2.0
                    )
                )
            ]
        );
    }
}
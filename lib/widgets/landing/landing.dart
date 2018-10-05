import 'package:flutter/material.dart';

import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/landing/login.dart';
import 'package:Social/widgets/landing/signup.dart';
import 'package:Social/widgets/landing/phone-number.dart';

class LandingPage extends StatefulWidget {
  LandingPage() : super();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Utils.getBackground(),
          PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: this._controller,
              children: <Widget>[
                Column(children: <Widget>[
                  Utils.getSpacer(50.0),
                  Utils.getBackButton(() { Utils.tabBack(_controller, 1); }),
                  Utils.getSpacer(100.0),
                  LoginPage()
                ]),
                Column(children: <Widget>[
                  Utils.getSpacer(50.0),
                  Utils.getBranding(),
                  Utils.getSpacer(75.0),
                  _getBody()
                ]),
								Column(children: <Widget>[
                  Utils.getSpacer(50.0),
                  Utils.getBackButton(() { Utils.tabBack(_controller, 1); }),
                  Utils.getSpacer(100.0),
                  SignupPage(controller: _controller)
                ]),
								Column(children: <Widget>[
                  Utils.getSpacer(50.0),
                  Utils.getBackButton(() { Utils.tabBack(_controller, 2); }),
                  Utils.getSpacer(100.0),
                  PhoneNumberPage()
                ])
              ])
        ]));
  }

  _getBody() {
    return Column(children: <Widget>[_getButtons()]);
  }

  _getButtons() {
    return Column(children: <Widget>[
      Container(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FlatButton(
								materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(5.0),
                onPressed: () {
                  _controller.animateToPage(0,
                      duration: new Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                },
                color: Color(0xFF00A0BE),
                textColor: Color(0xFFFFFFFF),
                child: Text('LOGIN',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 2.0)),
              ))),
      Container(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    _controller.animateToPage(2,
                         duration: new Duration(milliseconds: 250),
                         curve: Curves.easeIn);
                  },
                  color: Color(0x00000000),
                  textColor: Color(0xFF525252),
                  child: Text('SIGN UP',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12.0,
                          color: Color(0xFF525252),
                          letterSpacing: 2.0)))))
    ]);
  }
}

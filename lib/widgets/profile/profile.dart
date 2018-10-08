import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/common/bottom-nav.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage() : super();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: SafeArea(
                child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(25.0),
                  child: Utils.getTitle('PROFILE', null)),
              Center(
                  child: Container(
                      decoration: new BoxDecoration(color: Colors.black54),
                      padding: EdgeInsets.all(20.0),
                      child: Column(children: <Widget>[
                        Text('ANDREW SMITH',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 25.0,
                                color: Color(0xFFFFFFFF))),
                        Container(
                            height: 2.0,
                            margin: EdgeInsets.all(10.0),
                            color: Colors.white),
                        Text('AKRON, OH',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                color: Color(0xFFFFFFFF))),
                        Container(
                            padding: EdgeInsets.all(25.0),
                            child: Text(
                                'Cannot wait to see all my friends on Social!',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 24.0,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFFFFFFFF)),
                                textAlign: TextAlign.center)),
                        Container(
                            child: Image.asset('images/icon_events.png',
                                alignment: Alignment(0.0, 2.0), height: 150.0))
                      ]))),
              Expanded(
                  child: Column(children: <Widget>[
                Utils.getFlatButton('MOMENTS', () {
                  Navigator.pushNamed(context, 'moments');
                }),
                Container(padding: EdgeInsets.all(8.0)),
                Utils.getFlatButton('ALBUMS', () {
                  Navigator.pushNamed(context, 'albums');
                }),
                Container(padding: EdgeInsets.all(8.0)),
                Utils.getFlatButton('NEW MEETUP', () {
                  Navigator.pushNamed(context, 'newmeetup');
                })
              ])),
              BottomNav().build(
                  leftAction: () {
                    Navigator.pop(context);
                  },
                  leftIcon: FontAwesomeIcons.arrowLeft,
                  rightAction: () {
                    Navigator.pop(context);
                  },
                  rightIcon: FontAwesomeIcons.cog)
            ]))));
  }
}

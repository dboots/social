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
            decoration: new BoxDecoration(color: Color(0xFFFFFFFA)),
            child: SafeArea(
                child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(25.0),
                  child: Utils.getTitle('PROFILE', null)),
              Center(
                  child: Container(
                      decoration: new BoxDecoration(color: Colors.black54),
                      margin: EdgeInsets.only(bottom: 45.0),
                      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 5.0, right: 5.0),
                          child: Text('ANDREW SMITH',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 23.0,
                                  letterSpacing: 2.5,
                                  color: Color(0xFFFFFFFF)),
                              textAlign: TextAlign.center)
                        ),
                        Container(
                            height: 2.0,
                            margin: EdgeInsets.all(5.0),
                            color: Colors.white
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text('AKRON, OH',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15.0,
                                  letterSpacing: 2.5,
                                  color: Color(0xFFFFFFFF)),
                              textAlign: TextAlign.center)
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                            child: Text(
                                "Can't wait to see all my friends on Social!",
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 2.5,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFFFFFFFF)),
                                textAlign: TextAlign.center)
                        ),
                        Container( child:  Transform(
                            child: Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/12.png')
                                  )
                              )
                            ),
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..scale(1.4)
                              ..translate(0.0, 35.0),
                          )
                        )
                      ]))),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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

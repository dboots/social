import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/services/shared-prefs.dart';
import 'package:Social/services/cliques.dart';
import 'package:Social/services/account.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage() : super();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  CliqueService _cliqueService = CliqueService();
  AccountService _accountService = AccountService();

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
              Expanded(child: _getIcons()),
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: IconButton(
                        iconSize: 40.0,
                        onPressed: () {
                          SharedPrefs().instance.remove('token');
                          _cliqueService.cliques = [];
                          _accountService = null;
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        icon: Icon(FontAwesomeIcons.cog,
                            size: 40.0, color: Color(0xFF999999)))),
                Expanded(child: Container()),
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: IconButton(
                        iconSize: 40.0,
                        onPressed: () {
                          Navigator.pushNamed(context, 'camera');
                        },
                        icon: Icon(FontAwesomeIcons.camera,
                            size: 40.0, color: Color(0xFF999999))))
              ])
            ]))));
  }

  _getIcons() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _getIcon('images/icon_profile.png', 'PROFILE', () {
            Navigator.pushNamed(context, 'profile');
          }),
          _getIcon('images/icon_cliques.png', 'CLIQUES', () {
            Navigator.pushNamed(context, 'cliques');
          }),
          _getIcon('images/icon_meetup.png', 'MEETUP', () {}),
          _getIcon('images/icon_events.png', 'EVENTS', () {})
        ]);
  }

  _getIcon(String asset, String label, Function onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Column(children: <Widget>[
          Image.asset(asset, height: 75.0),
          Text(label,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 17.0,
                  color: Color(0xFF525252),
                  letterSpacing: 4.0)),
        ]));
  }
}

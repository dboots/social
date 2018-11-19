import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/services/shared-prefs.dart';
import 'package:Social/services/cliques.dart';
import 'package:Social/services/account.dart';
import 'package:Social/services/user.dart';
import 'package:Social/models/account.dart';
import 'package:Social/models/user.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage() : super();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  CliqueService _cliqueService = CliqueService();
  UserService _userService = UserService();
  AccountService _accountService = AccountService();
  Account _account;
  User _user;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  int _themeIndex = 0;
  List<int> _themeColors = [
    0xFFDEDEDE,
    0xFF00FF00,
    0xFF00FFFF,
    0xFFFFFF00,
    0xFF000000
  ];

  @override
  void initState() {
    super.initState();

    _account = _accountService.account;
    _user = _account.user;

    if (_user.theme == null) {
      _themeIndex = 0;
    } else {
      _themeIndex =
          _themeColors.indexWhere((c) => c.toRadixString(16) == _user.theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  _getBody(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: SafeArea(
                child: Column(children: <Widget>[
              PageTitle(label: 'SETTINGS'),
              Expanded(
                  child: Column(children: <Widget>[
                Container(
                    decoration:
                        BoxDecoration(color: Color(_themeColors[_themeIndex])),
                    child: Column(children: <Widget>[
                      Slider(
                          value: _themeIndex.toDouble(),
                          min: 0.0,
                          max: (_themeColors.length - 1).toDouble(),
                          divisions: (_themeColors.length - 1),
                          onChanged: (double value) {
                            setState(() {
                              _themeIndex = value.toInt();
                            });
                          })
                    ]),
                    height: 250.0),
                Container(
                    padding: EdgeInsets.only(
                        top: 25.0, left: 5.0, bottom: 8.0, right: 5.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xFF666666)))),
                    child: Row(children: <Widget>[
                      Text('PERSONAL INFORMATION',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF666666),
                              letterSpacing: 2.0))
                    ])),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Container(
                                  child: TextFormField(
                                decoration: InputDecoration(labelText: 'NAME'),
                                onSaved: (String value) {
                                  _user.name = value;
                                },
                                initialValue: _user.name,
                              )),
                              Container(
                                  child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'LOCATION'),
                                onSaved: (String value) {
                                  _user.location = value;
                                },
                                initialValue: _user.location,
                              )),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 25.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 25.0),
                                                child: FractionallySizedBox(
                                                    widthFactor: 0.6,
                                                    child: FlatButton(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        color:
                                                            Color(0xFF999999),
                                                        textColor:
                                                            Color(0xFFFFFFFF),
                                                        child: Text('LOGOUT'),
                                                        onPressed: () {
                                                          SharedPrefs()
                                                              .instance
                                                              .remove('token');
                                                          _cliqueService
                                                              .headers = null;
                                                          _cliqueService
                                                              .cliques = [];
                                                          _accountService
                                                              .token = null;
                                                          _accountService
                                                              .account = null;
                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context, '/');
                                                        }))),
                                            Text('Social',
                                                style: TextStyle(
                                                    fontFamily: 'Watermelon',
                                                    fontSize: 60.0,
                                                    color: Color(0xFF999999)))
                                          ])))
                            ])))),
                BottomNav(
                    leftIcon: FontAwesomeIcons.arrowLeft,
                    leftAction: () {
                      Navigator.pop(context);
                    },
                    middleAction: () async {
                      final FormState form = _formKey.currentState;
                      form.save();
                      _user.theme = _themeColors[_themeIndex].toRadixString(16);
                      await _userService.update({
                        'full_name': _user.name,
                        'location': _user.location,
                        'theme': _user.theme
                      });
                    },
                    middleLabel: 'SAVE'),
              ]))
            ]))));
  }
}

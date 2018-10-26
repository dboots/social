import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/widgets/common/line-item.dart';
import 'package:Social/services/account.dart';
import 'package:Social/services/cliques.dart';
import 'package:Social/models/account.dart';
import 'package:Social/models/user.dart';
import 'package:Social/models/clique.dart';

class CreateCliquePage extends StatefulWidget {
  CreateCliquePage() : super();

  @override
  _CreateCliquePageState createState() => _CreateCliquePageState();
}

class _CreateCliquePageState extends State<CreateCliquePage> {
  AccountService _accountService = AccountService();
  CliqueService _cliqueService = CliqueService();
  Account _account;
  User _user;
  List<dynamic> _friends;
  Clique _clique = Clique();
  bool _isReady = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _account = _accountService.account;
      _user = _account.user;
      _friends = _user.friends;
      _isReady = true;
      _clique.members = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_isReady) ? _getBody() : Container();
  }

  _getBody() {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: SafeArea(
                child: Column(children: <Widget>[
              PageTitle(label: 'CREATE CLIQUE'),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: TextField(
                          onChanged: (val) {
                            _clique.name = val;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'NAME CLIQUE',
                            border: InputBorder.none,
                          ))),
                  Expanded(
                      child: ListView.builder(
                    itemCount: _friends.length,
                    itemBuilder: (context, index) {
                      dynamic friend = _friends.elementAt(index);
                      return LineItem(
                          label: friend['full_name'],
                          widgets: _getIcons(friend));
                    },
                  ))
                ],
              )),
              BottomNav(
                leftIcon: FontAwesomeIcons.arrowLeft,
                leftAction: () {
                  Navigator.pop(context);
                },
                middleAction: () async {
                  bool result = await _cliqueService.createClique(_clique);

                  if (result) {
                    Navigator.pop(context);
                  } else {
                    // alert overlay error
                  }
                },
                middleLabel: 'SAVE',
              )
            ]))));
  }

  List<Widget> _getIcons(dynamic friend) {
    return [
      GestureDetector(
          child: Icon(FontAwesomeIcons.plusCircle, size: 18.0),
          onTap: () {
            if (_clique.members.where((f) {
                  return f == friend['_id'];
                }).length ==
                0) {
              _clique.members.add(User.fromMap(friend));
            }
          })
    ];
  }
}

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
  final Clique clique;
  CreateCliquePage({Key key, this.clique}) : super(key: key);

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
  bool _isUpdating = false;

  TextEditingController _cliqueNameController;

  @override
  void initState() {
    super.initState();

    if (widget.clique != null) {
      _isUpdating = true;
      _cliqueNameController =
          new TextEditingController(text: widget.clique.name);
    }

    setState(() {
      _account = _accountService.account;
      _user = _account.user;
      _friends = _user.friends;
      _isReady = true;
      _clique = (_isUpdating) ? widget.clique : Clique();

      _clique.members = (_isUpdating && widget.clique.members != null)
          ? widget.clique.members
          : [];
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
                          controller: _cliqueNameController,
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
                  bool result = false;
                  if (_isUpdating) {
                    result = await _cliqueService.update(_clique);
                  } else {
                    result = await _cliqueService.create(_clique);
                  }

                  if (result) {
                    Navigator.pop(context);
                  } else {
                    // alert overlay error
                  }
                },
                middleLabel: (_isUpdating) ? 'UPDATE' : 'SAVE',
              )
            ]))));
  }

  List<Widget> _getIcons(dynamic friend) {
    if (_clique.members.where((c) {
          return c.id == friend['_id'];
        }).length >
        0) {
      return [
        GestureDetector(
            child: Icon(FontAwesomeIcons.timesCircle, size: 18.0),
            onTap: () {
              setState(() {
                _clique.members.removeWhere((c) => c.id == friend['_id']);
              });
            })
      ];
    } else {
      return [
        GestureDetector(
            child: Icon(FontAwesomeIcons.plusCircle, size: 18.0),
            onTap: () {
              if (_clique.members.where((f) {
                    return f.id == friend['_id'];
                  }).length ==
                  0) {
                setState(() {
                  _clique.members.add(User.fromMap(friend));
                });
              }
            })
      ];
    }
  }
}

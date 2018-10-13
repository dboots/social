import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/services/cliques.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/clique.dart';

class CliquesPage extends StatefulWidget {
  CliquesPage() : super();

  @override
  _CliquesPageState createState() => _CliquesPageState();
}

class _CliquesPageState extends State<CliquesPage> {
  String _selected = 'CLIQUES';
  PageController _controller = PageController();
  CliqueService _cliqueService = CliqueService();
  AccountService _accountService = AccountService();
  List<Clique> _cliques = [];
  List _friends = [];
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _getCliques();
  }

  Future<List<Clique>> _getCliques() async {
    return _cliqueService.getCliques().then((data) {
      setState(() {
        _cliques = data;
        _isReady = true;
        _friends = _accountService.account.user.friends;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) return Container();
    return _getBody();
  }

  _getBody() {
    BoxDecoration decoration = BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 2.0, color: Color(0xFF666666))));

    return Scaffold(
        body: Container(
            child: SafeArea(
                child: Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(15.0),
          child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: (_selected == 'CLIQUES') ? decoration : null,
                    child: Utils.getTitle('CLIQUES', () {
                      setState(() {
                        _selected = 'CLIQUES';
                      });
                      _controller.animateToPage(0,
                          duration: new Duration(milliseconds: 250),
                          curve: Curves.easeIn);
                    }))),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: (_selected == 'FRIENDS') ? decoration : null,
                    child: Utils.getTitle('FRIENDS', () {
                      setState(() {
                        _selected = 'FRIENDS';
                      });
                      _controller.animateToPage(1,
                          duration: new Duration(milliseconds: 250),
                          curve: Curves.easeIn);
                    })))
          ])),
      Expanded(
        child: PageView(
            onPageChanged: (page) {
              var selected = 'CLIQUES';

              if (page == 1) {
                selected = 'FRIENDS';
              }

              setState(() {
                _selected = selected;
              });
            },
            controller: _controller,
            children: <Widget>[
              Column(children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  itemCount: _cliques.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Color(0xFFFF0000),
                          child: Text(_cliques[index].name.substring(0, 1),
                              style: TextStyle(color: Colors.white))),
                      title: Text(_cliques[index].name,
                          style: TextStyle(
                              fontSize: 16.0, color: Color(0xFF666666))),
                    );
                  },
                )),
                BottomNav().build(
                    leftIcon: FontAwesomeIcons.arrowLeft,
                    leftAction: () {
                      Navigator.pop(context);
                    },
                    middleAction: () {},
                    middleLabel: 'CREATE')
              ]),
              Column(children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  itemCount: _friends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Color(0xFFFF0000),
                          child: Text(
                              _friends[index]['full_name']
                                  .toString()
                                  .substring(0, 1),
                              style: TextStyle(color: Colors.white))),
                      title: Text(
                          _friends[index]['full_name'].toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 16.0, color: Color(0xFF666666))),
                    );
                  },
                )),
                BottomNav().build(
                    leftIcon: FontAwesomeIcons.arrowLeft,
                    leftAction: () {
                      Navigator.pop(context);
                    },
                    middleAction: () {
                      Navigator.pushNamed(context, 'cliques/friends/add');
                    },
                    middleLabel: 'ADD FRIEND')
              ])
            ]),
      )
    ]))));
  }
}

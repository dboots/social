import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/bottom-nav.dart';

class CliquesPage extends StatefulWidget {
  CliquesPage() : super();

  @override
  _CliquesPageState createState() => _CliquesPageState();
}

class _CliquesPageState extends State<CliquesPage> {
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    var data = [
      {
        "_id": "5a669b9e06bb8c0011119665",
        "updatedAt": "2018-01-23T02:19:10.274Z",
        "createdAt": "2018-01-23T02:19:10.274Z",
        "owner": "5a654cfc29c5ed0010435a4c",
        "__v": 0,
        "members": ["5a654cfc29c5ed0010435a4c"],
        "name": "WOO"
      }
    ];

    for (num i = 0; i < 125; i++) {
      data.add({
        "_id": "5a669b9e06bb8c0011119665",
        "updatedAt": "2018-01-23T02:19:10.274Z",
        "createdAt": "2018-01-23T02:19:10.274Z",
        "owner": "5a654cfc29c5ed0010435a4c",
        "__v": 0,
        "members": ["5a654cfc29c5ed0010435a4c"],
        "name": "WOO"
      });
    }
		
    List<Row> cliques = data
        .map((d) => Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: CircleAvatar(
                      backgroundColor: Color(0xFFFF0000),
                      child: Text('A', style: TextStyle(color: Colors.white)))),
              Text(d["name"], style: TextStyle(fontSize: 18.0))
            ]))
        .toList();

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
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFF666666)))),
                    child: Utils.getTitle('CLIQUES', () {
                      _controller.animateToPage(0,
                          duration: new Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    }))),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFF666666)))),
                    child: Utils.getTitle('FRIENDS', () {
                      _controller.animateToPage(1,
                          duration: new Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    })))
          ])),
      Expanded(
          child: PageView(controller: _controller, children: <Widget>[
        Column(children: <Widget>[
          Expanded(
              child: SingleChildScrollView(child: Column(children: cliques))),
          BottomNav(
                  leftAction: () {
                    Navigator.pop(context);
                  },
                  leftIcon: FontAwesomeIcons.arrowLeft,
                  middleAction: () {
                    Navigator.pushNamed(context, 'dashboard');
                  },
                  middleLabel: 'CREATE',
                  rightAction: () {},
                  rightIcon: FontAwesomeIcons.arrowRight)
              .build()
        ]),
        Container(
            child: SingleChildScrollView(child: Column(children: cliques)))
      ])),
    ]))));
  }
}

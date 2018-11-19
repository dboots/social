import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/widgets/common/line-item.dart';
import 'package:Social/services/cliques.dart';
import 'package:Social/services/account.dart';
import 'package:Social/services/user.dart';
import 'package:Social/models/clique.dart';
import 'package:Social/widgets/common/alert-overlay.dart';

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
  UserService _userService = UserService();
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
    return Scaffold(body: (!_isReady) ? Container() : _getBody());
  }

  _getBody() {
    BoxDecoration decoration = BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 2.0, color: Color(0xFF666666))));

    return Container(
        child: SafeArea(
            child: Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(15.0),
          child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemCount: _cliques.length,
                    itemBuilder: (context, index) {
                      return LineItem(
                          label: _cliques[index].name,
                          widgets: _getCliquesWidgets());
                    },
                  )),
                  BottomNav(
                      leftIcon: FontAwesomeIcons.arrowLeft,
                      leftAction: () {
                        Navigator.pop(context);
                      },
                      middleAction: () {
												Navigator.pushNamed(context, 'cliques/create');
											},
                      middleLabel: 'CREATE')
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getFriendContainers()),
                  )),
                  BottomNav(
                      leftIcon: FontAwesomeIcons.arrowLeft,
                      leftAction: () {
                        Navigator.pop(context);
                      },
                      middleAction: () {
                        Navigator.pushNamed(context, 'cliques/friends/add');
                      },
                      middleLabel: 'ADD FRIEND')
                ])
          ]))
    ])));
  }

  List<Widget> _getCliquesWidgets() {
    return [Icon(FontAwesomeIcons.edit, size: 18.0)];
  }

  List<Widget> _getFriendWidgets(dynamic friend) {
		String friendId = friend['_id'];
    return [
      GestureDetector(
          child: Icon(FontAwesomeIcons.timesCircle, size: 18.0),
          onTap: () async {
            AlertOverlay alertOverlay = AlertOverlay(
                title: 'REMOVE FRIEND',
                body: 'Would you like to remove ' + friend['full_name'] + '?',
                buttonLabel: 'OK',
                buttonAction: () async {
                  bool result = await _userService.denyFriendRequest(friendId);
                  if (result) {
                    setState(() {
                      _accountService.account.user.friends
                          .removeWhere((x) => x['_id'] == friendId);
                    });
                  }
                });

            alertOverlay.showOverlay(context);
          })
    ];
  }

  List<Widget> _getFriendRequestWidgets(dynamic request) {
		String requestId = request['_id'];
    return [
      Container(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
              child: Icon(FontAwesomeIcons.timesCircle, size: 18.0),
              onTap: () async {
                AlertOverlay alertOverlay = AlertOverlay(
                    title: 'DENY FRIEND',
                    body: 'Would you like to deny ' + request['full_name'] + '?',
                    buttonLabel: 'OK',
                    buttonAction: () async {
                      bool success =
                          await _userService.denyFriendRequest(requestId);

                      if (success) {
                        setState(() {
                          _accountService.account.user.requests
                              .removeWhere((x) => x['_id'] == requestId);
                        });
                      }
                    });

                alertOverlay.showOverlay(context);
              })),
      Container(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
              child: Icon(FontAwesomeIcons.checkCircle, size: 18.0),
              onTap: () async {
                AlertOverlay alertOverlay = AlertOverlay(
                    title: 'APPROVE FRIEND',
                    body: 'Would you like to approve ' + request['full_name'] + '?',
                    buttonLabel: 'OK',
                    buttonAction: () async {
                      bool success =
                          await _userService.approveFriendRequest(requestId);

                      if (success) {
                        setState(() {
                          _accountService.account.user.requests
                              .removeWhere((x) => x['_id'] == requestId);
													_accountService.account.user.friends.add(request);
                        });
                      }
                    });

                alertOverlay.showOverlay(context);
              }))
    ];
  }

  List<Widget> _getFriendRequests() {
    List<Widget> rows = _accountService.account.user.requests.map((request) {
      return LineItem(
          label: request['full_name'],
          widgets: _getFriendRequestWidgets(request));
    }).toList();

    return rows;
  }

  List<Widget> _getFriends() {
    List<Widget> rows = _friends.map((friend) {
      return LineItem(
          label: friend['full_name'],
          widgets: _getFriendWidgets(friend));
    }).toList();

    return rows;
  }

  List<Widget> _getFriendContainers() {
    List<Widget> containers = [];

    if (_accountService.account.user.requests.length > 0) {
      containers.add(Container(
          padding: EdgeInsets.all(10.0),
          child: Text('REQUESTS', style: TextStyle(fontSize: 16.0))));
      containers.add(Column(children: _getFriendRequests()));
    }

    if (_accountService.account.user.friends.length > 0) {
      containers.add(Container(
          padding: EdgeInsets.all(10.0),
          child: Text('ADDED', style: TextStyle(fontSize: 16.0))));
      containers.add(Column(children: _getFriends()));
    }

    return containers;
  }
}

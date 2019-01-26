import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/services/account.dart';
import 'package:Social/widgets/common/line-item.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/services/moments.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  AccountService _accountService = AccountService();
  MomentsService _momentsService = MomentsService();
  List _friends = [];
  List _shares = [];

  @override
  void initState() {
    super.initState();

    print(_accountService.account.user.friends);

    setState(() {
      _friends = _accountService.account.user.friends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    return Scaffold(
        body: Container(
            child: SafeArea(
                child: Column(children: <Widget>[
      PageTitle(label: 'SHARE'),
      Expanded(
          child: ListView.builder(
              itemCount: _friends.length,
              itemBuilder: (context, index) {
                var friend = _friends.elementAt(index);
                return LineItem(
                    label: friend['full_name'], widgets: _getShareIcon(friend));
              })),
      BottomNav(
          leftIcon: FontAwesomeIcons.arrowLeft,
          leftAction: () {
            Navigator.pop(context);
          },
          middleAction: () async {
            List<dynamic> members = _shares.map((s) => s['_id']).toList();
						print(_shares);
            print(members);

            dynamic body = {
              'owner': _accountService.account.user.id,
              'members': members,
              'body': 'test'
            };

            await _momentsService.create(body);
          },
          middleLabel: 'SHARE')
    ]))));
  }

  List<Widget> _getShareIcon(friend) {
    var icons = <Widget>[];
    bool exists = (_shares.where((f) {
          print('comparing ' + f['_id'] + ' with ' + friend['_id']);
          return f['_id'] == friend['_id'];
        }).length >
        0);

    if (!exists) {
      icons.add(GestureDetector(
          child: Icon(FontAwesomeIcons.plusCircle, size: 18.0),
          onTap: () {
            setState(() {
              setState(() {
                _shares.add(friend);
              });
            });
          }));
    } else {
      icons.add(GestureDetector(
          child: Icon(FontAwesomeIcons.checkCircle, size: 18.0),
          onTap: () {
            setState(() {
              _shares.removeWhere((f) {
                return f['_id'] == friend['_id'];
              });
            });
          }));
    }

    return icons;
  }
}

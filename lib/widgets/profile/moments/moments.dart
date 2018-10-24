import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/widgets/common/image-overlay.dart';
import 'package:Social/widgets/common/review-card.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/user.dart';
import 'package:Social/models/account.dart';

class MomentsPage extends StatefulWidget {
  MomentsPage() : super();

  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  AccountService _accountService = AccountService();
  User _user;
  Account _account;

  String _dinnerTestlabel = "So nice seeing you last night! We should definitely make it a weekly thing!";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _account = _accountService.account;
    _user = _account.user;
    return _getBody();
  }

  _getBody() {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(color: Color(0xFFFFFFFA)),
        child: SafeArea(
          child: Column(children: <Widget>[
            PageTitle(label: 'MOMENTS'),
            Center(
              child: Container(
                decoration: new BoxDecoration(color: Colors.black54),
                child: Column(children: [
                    ImageOverlay(label: 'DINNER', url: 'images/dinner-test.jpg'),
                    ReviewCard(
                      avatarUrl: 'images/12.png',
                      userName: 'Flutter Test',
                      reviewDate: 'JAN 15 5:45 PM',
                      labelContent: _dinnerTestlabel
                    )
                  ]
                )
              )
            ),
            BottomNav(
              leftAction: () {
                Navigator.pop(context);
              },
              leftIcon: FontAwesomeIcons.arrowLeft,
              rightAction: () {
                Navigator.pop(context);
              },
              rightIcon: FontAwesomeIcons.cog)
          ])
        )
      )
    );
  }
}

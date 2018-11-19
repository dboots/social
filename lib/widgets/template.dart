import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/widgets/common/bottom-nav.dart';

class Page extends StatefulWidget {
	Page() : super();

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
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
              PageTitle(label: 'SETTINGS'),
							Expanded(child: Container()),
              BottomNav(
                  leftIcon: FontAwesomeIcons.arrowLeft,
                  leftAction: () {
                    Navigator.pop(context);
                  })
            ]))));
  }
}

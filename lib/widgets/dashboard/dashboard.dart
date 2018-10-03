import 'package:flutter/material.dart';

import 'package:Social/widgets/common/utils.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage() : super();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 1);

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
              Utils.getBackButton(() { Navigator.pushNamed(context, '/'); }),
              Utils.getSpacer(125.0),
              Center(child: _getIcons())
            ]))));
  }

  _getIcons() {
    return Column(children: <Widget>[
      _getIcon('images/icon_cliques.png', 'CLIQUES'),
      _getIcon('images/icon_cliques.png', 'CLIQUES'),
      _getIcon('images/icon_cliques.png', 'CLIQUES'),
      _getIcon('images/icon_cliques.png', 'CLIQUES')
    ]);
  }

  _getIcon(String asset, String label) {
    return Column(children: <Widget>[
      Image.asset('images/icon_cliques.png'),
      Utils.getSpacer(10.0),
      Text('CLIQUES',
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 17.0,
              color: Color(0xFF525252),
              letterSpacing: 2.0)),
      Utils.getSpacer(60.0),
    ]);
  }
}

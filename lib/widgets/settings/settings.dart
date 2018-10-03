import 'package:flutter/material.dart';

import 'package:Social/widgets/common/utils.dart';

class SettingsPage extends StatefulWidget {
    SettingsPage() : super();
    
    @override
    _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
    PageController _controller = PageController(initialPage: 1);

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
                children: <Widget>[
                    Utils.getBackground(),
                    PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: this._controller,
                        children: <Widget>[
                            Column(
                                children: <Widget>[
                                    Utils.getSpacer(50.0),
                                    FractionallySizedBox(
                                        widthFactor: 0.8,
                                        child: Utils.getBackButton(this._controller)
                                    ),
                                    Utils.getSpacer(100.0)
                                ]
                            ),
                            Column(
                                children: <Widget>[
                                    Utils.getSpacer(50.0),
                                    Utils.getBranding(),
                                    Utils.getSpacer(75.0),
                                    _getBody()
                                ]
                            ),
                            Column(
                                children: <Widget>[
                                    Utils.getSpacer(50.0),
                                    FractionallySizedBox(
                                        widthFactor: 0.8,
                                        child: Utils.getBackButton(this._controller)
                                    ),
                                    Utils.getSpacer(100.0)
                                ]
                            )
                        ]
                    )        
                ]
            )
        );
    }

    _getBody() {
        return Column(
            children: <Widget>[
                _getButtons()
            ]
        );
    }

    _getButtons() {
        return Column(
            children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FlatButton(
                            onPressed: () {
                                _controller.animateToPage(0, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
                            },
                            color: Color(0xFF00A0BE),
                            textColor: Color(0xFFFFFFFF),
                            child: Text('LOGIN'),
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FlatButton(
                            onPressed: () {
                                _controller.animateToPage(2, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
                            },
                            color: Color(0x00000000),
                            textColor: Color(0xFF525252),
                            child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.0,
                                    color: Color(0xFF525252),
                                    letterSpacing: 2.0
                                )
                            )
                        )
                    )
                )
            ]
        );
    }
}
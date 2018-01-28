import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignupPage extends StatefulWidget {
    SignupPage() : super();

    @override
    _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    PageController _controller;
    
    @override
    Widget build(BuildContext context) {
        return _getBody();
    }

    _getBody() {
        return new FractionallySizedBox(
            widthFactor: 0.8,
            child: new Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'FULL NAME'
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            color: new Color(0xFF707070)
                        )

                    ),
                    new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'EMAIL',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            color: new Color(0xFF707070)
                        )

                    ),
                    new Container(
                        padding: new EdgeInsets.only(bottom: 15.0),
                        child: new TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'PASSWORD',
                            ),
                            obscureText: true,
                            style: new TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w100,
                                color: new Color(0xFF707070)
                            )
                        )
                    ),
                    new FractionallySizedBox(
                        widthFactor: 1.0,
                        child: new FlatButton(
                            onPressed: () {
                                Navigator.pushNamed(this._buildContext, '/Signup');
                            },
                            color: new Color(0xFF00A0BE),
                            textColor: new Color(0xFFFFFFFF),
                            child: new Text('SIGNUP')
                        )
                    )
                ]
            )
        );
    }
}
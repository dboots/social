import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage() : super();

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  _getBody(context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Center(
              child: Container(
                  child: Column(children: <Widget>[
            Text('ADD YOUR NUMBER',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20.0,
                    color: Color(0xFF525252),
                    letterSpacing: 2.0,
                    height: 3.0)),
            Text(
                'Providing your number provides friends with more ways to connect with you.',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF525252),
                    letterSpacing: 2.0),
                textAlign: TextAlign.center)
          ]))),
          Container(
              padding: EdgeInsets.only(top: 25.0),
              child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'PHONE #',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validateMobile,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF707070)))),
          Center(
              child: Container(
                  child: Column(children: <Widget>[
            Text('Your number will not be displayed publicly.',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF525252),
                    letterSpacing: 2.0,
                    height: 3.0),
                textAlign: TextAlign.center)
          ]))),
          FractionallySizedBox(
              widthFactor: 1.0,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'dashboard');
                },
                child: Text(
                  'NEXT',
                  style: TextStyle(
                      backgroundColor: Color(0xFF00A0BE),
                      color: Color(0xFFFFFFFF)),
                ),
              ))
        ]));
  }

  String validateMobile(String? value) {
    // Indian Mobile number are of 10 digit only
    if (value?.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return 'null';
  }
}

import 'package:flutter/material.dart';
import 'package:Social/services/account.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key key, this.controller}) : super();

  final PageController controller;

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  AccountService _accountService = AccountService();

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
              child: TextField(
                  onChanged: (val) {
                    _accountService.account.phone = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'PHONE #',
                  ),
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
              child: FlatButton(
                  onPressed: () async {
                    bool result = await _accountService
                        .update({'phone': _accountService.account.phone});
                    if (result) {
                      widget.controller.animateToPage(4,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeIn);
                    } else {
                      print('error updating account');
                    }
                  },
                  color: Color(0xFF00A0BE),
                  textColor: Color(0xFFFFFFFF),
                  child: Text('NEXT'),
                  shape: RoundedRectangleBorder(side: BorderSide.none)))
        ]));
  }

  String validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneVerifyPage extends StatefulWidget {
  PhoneVerifyPage() : super();

  @override
  _PhoneVerifyPageState createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _secondFocus = FocusNode();
  final FocusNode _thirdFocus = FocusNode();
  final FocusNode _forthFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _fieldFocusChange(context, currentFocus, nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _firstChange(text, context) {
    if (text.length == 1) {
      _fieldFocusChange(context, _firstFocus, _secondFocus);
    }
  }

  _secondChange(text, context) {
    if (text.length == 1) {
      _fieldFocusChange(context, _secondFocus, _thirdFocus);
    } else if (text.length == 0) {
      _fieldFocusChange(context, _secondFocus, _firstFocus);
    }
  }

  _thirdChange(text, context) {
    if (text.length == 1) {
      _fieldFocusChange(context, _thirdFocus, _forthFocus);
    } else if (text.length == 0) {
      _fieldFocusChange(context, _thirdFocus, _secondFocus);
    }
  }

  _forthChange(text, context) {
    if (text.length == 0) {
      _fieldFocusChange(context, _forthFocus, _thirdFocus);
    }
  }

  _getBody(context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Center(
              child: Container(
                  child: Column(children: <Widget>[
            Text('VERIFY YOUR NUMBER',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20.0,
                    color: Color(0xFF525252),
                    letterSpacing: 2.0,
                    height: 3.0)),
            Text(
                'Please type in the 4 digit verification code you recieved via SMS',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF525252),
                    letterSpacing: 2.0),
                textAlign: TextAlign.center)
          ]))),
          Center(
              child: Container(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                decoration: const InputDecoration(
                                    labelText: '',
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  _firstChange(text, context);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _firstFocus,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _firstFocus, _secondFocus);
                                },
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Color(0xFF707070))))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                maxLength: 1,
                                decoration: const InputDecoration(
                                    labelText: '',
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  _secondChange(text, context);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _secondFocus,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _secondFocus, _thirdFocus);
                                },
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Color(0xFF707070))))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                maxLength: 1,
                                decoration: const InputDecoration(
                                    labelText: '',
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  _thirdChange(text, context);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _thirdFocus,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _thirdFocus, _forthFocus);
                                },
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Color(0xFF707070))))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                maxLength: 1,
                                decoration: const InputDecoration(
                                    labelText: '',
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  _forthChange(text, context);
                                },
                                textInputAction: TextInputAction.done,
                                focusNode: _forthFocus,
                                onSubmitted: (term) {
                                  _forthFocus.unfocus();
                                  Navigator.pushNamed(context, 'dashboard');
                                },
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Color(0xFF707070)))))
                  ]))),
          FractionallySizedBox(
              widthFactor: 1.0,
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'dashboard');
                  },
                  color: Color(0xFF00A0BE),
                  textColor: Color(0xFFFFFFFF),
                  child: Text('GET SOCIAL!'),
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

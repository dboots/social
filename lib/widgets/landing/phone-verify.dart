import 'package:flutter/material.dart';

class PhoneVerifyPage extends StatefulWidget {
  PhoneVerifyPage() : super();

  @override
  _PhoneVerifyPageState createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
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
          Center( child: Container(padding: EdgeInsets.only(top: 25.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      maxLength: 1,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                        )
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF707070)))
                    )
                  ),
                  Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      maxLength: 1,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                        )
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF707070)))
                    )
                  ),
                  Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      maxLength: 1,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                        )
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF707070)))
                    )
                  ),
                  Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      maxLength: 1,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                        )
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF707070)))
                    )
                  )
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

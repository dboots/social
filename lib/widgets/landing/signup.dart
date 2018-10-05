import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({
		Key key,
		this.controller
	}) : super();

	final PageController controller;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  _getBody(context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(labelText: 'FULL NAME'),
              keyboardType: TextInputType.text,
              autocorrect: false,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w100,
                  color: Color(0xFF707070))),
          TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
                labelText: 'EMAIL',
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w100,
                  color: Color(0xFF707070))),
          Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'PASSWORD',
                  ),
                  obscureText: true,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF707070)))),
          FractionallySizedBox(
              widthFactor: 1.0,
              child: FlatButton(
                  onPressed: () {
                    widget.controller.animateToPage(3,
                        duration: new Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                    // Navigator.pushNamed(context, '/Signup');
                  },
                  color: Color(0xFF00A0BE),
                  textColor: Color(0xFFFFFFFF),
                  child: Text('SIGNUP'),
                  shape: RoundedRectangleBorder(side: BorderSide.none)))
        ]));
  }
}

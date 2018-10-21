import 'package:flutter/material.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/account.dart';
import 'package:Social/widgets/common/alert-overlay.dart';

class SignUpData {
  String name;
  String email;
  String password;
}

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.controller}) : super();

  final PageController controller;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignUpData _signupData = SignUpData();
  AccountService _accountService = AccountService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  _getBody(context) {
    return Form(
        key: _formKey,
        child: FractionallySizedBox(
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
                    color: Color(0xFF707070)),
                onSaved: (String value) {
                  _signupData.name = value;
                },
              ),
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
                    color: Color(0xFF707070)),
                onSaved: (String value) {
                  _signupData.email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'PASSWORD',
                ),
                obscureText: true,
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF707070)),
                onSaved: (String value) {
                  _signupData.password = value;
                },
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'CONFIRM PASSWORD',
                  ),
                  obscureText: true,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF707070))),
              Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: FlatButton(
                          onPressed: () async {
                            final FormState form = _formKey.currentState;
                            form.save();

														// TODO: change result to a Response model { success, body }
                            dynamic result =
                                await this._accountService.signup({
																	'name': _signupData.name,
																	'username': _signupData.email,
																	'password': _signupData.password
																});

                            if (result['success']) {
                              widget.controller.animateToPage(3,
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.easeIn);
                            } else {
                              AlertOverlay alertOverlay = AlertOverlay(
                                  title: 'ERROR',
                                  body: 'An error has occurred',
                                  buttonLabel: 'TRY AGAIN');
                              alertOverlay.showOverlay(context);
                            }
                          },
                          color: Color(0xFF00A0BE),
                          textColor: Color(0xFFFFFFFF),
                          child: Text('SIGNUP'),
                          shape:
                              RoundedRectangleBorder(side: BorderSide.none))))
            ])));
  }
}

import 'package:flutter/material.dart';
import 'package:Social/services/account.dart';
import 'package:Social/widgets/common/alert-overlay.dart';

class SignUpData {
  String? email;
  String? password;
}

class LoginPage extends StatefulWidget {
  LoginPage() : super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SignUpData _signupData = SignUpData();
  AccountService _accountService = AccountService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    AlertOverlay alertOverlay = AlertOverlay(
        title: 'ERROR', body: 'Invalid login', buttonLabel: 'TRY AGAIN');

    return Form(
        key: _formKey,
        child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: 'EMAIL'),
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF707070)),
                onChanged: (String value) {
                  _signupData.email = value;
                },
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: 'PASSWORD'),
                    obscureText: true,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF707070)),
                    onChanged: (String value) {
                      this._signupData.password = value;
                    },
                  )),
              FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextButton(
                    onPressed: () async {
                      final FormState? form = _formKey.currentState;
                      form?.save();

                      bool result = await this._accountService.login(
                          this._signupData.email.toString(),
                          this._signupData.password.toString());

                      if (result) {
                        Navigator.pushReplacementNamed(context, 'dashboard');
                      } else {
                        alertOverlay.showOverlay(context);
                      }
                    },
                    child: Text('LOGIN',
                        style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 4.0,
                            color: Color(0xFFFFFFFF),
                            backgroundColor: Color(0xFF00A0BE))),
                  )),
            ])));
  }
}

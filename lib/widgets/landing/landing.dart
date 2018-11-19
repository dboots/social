import 'package:flutter/material.dart';

import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/landing/login.dart';
import 'package:Social/widgets/landing/signup.dart';
import 'package:Social/widgets/landing/phone-number.dart';
import 'package:Social/widgets/landing/phone-verify.dart';
import 'package:Social/widgets/dashboard/dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Social/services/account.dart';
import 'package:Social/services/shared-prefs.dart';

class LandingPage extends StatefulWidget {
  LandingPage() : super();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AccountService _accountService = AccountService();
  PageController _controller = PageController(initialPage: 1);
  String _token;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        print("token: $token");
      });
    });

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      setState(() {
        print("Settings registered: $settings");
      });
    });

    Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    fcmStream.listen((token) {
      setState(() {
        print("fcm token is: $token");
      });
    });

    SharedPrefs().initSharedPrefs().then((result) {
      String token = SharedPrefs().instance.getString('token');

      if (token != null) {
        _accountService.resume(token);
      }

      setState(() {
        _token = token;
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          print("onMessage: $message");
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          print("onLaunche: $message");
        });
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          print("onResume: $message");
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    if (_token != null && _token.isNotEmpty) {
      return DashboardPage();
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Utils.getBackground(),
          PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: this._controller,
              children: <Widget>[
                Column(children: <Widget>[
                  Utils.getBackButton(() {
                    Utils.tabBack(_controller, 1);
                  }),
                  LoginPage()
                ]),
                Column(children: <Widget>[Utils.getBranding(), _getBody()]),
                Column(children: <Widget>[
                  Utils.getBackButton(() {
                    Utils.tabBack(_controller, 1);
                  }),
                  SignupPage(controller: _controller)
                ]),
                Column(children: <Widget>[
                  Utils.getBackButton(() {
                    Utils.tabBack(_controller, 2);
                  }),
                  PhoneNumberPage(controller: _controller)
                ]),
                Column(children: <Widget>[
                  Utils.getBackButton(() {
                    Utils.tabBack(_controller, 3);
                  }),
                  PhoneVerifyPage()
                ])
              ])
        ]));
  }

  _getBody() {
    return Column(children: <Widget>[_getButtons()]);
  }

  _getButtons() {
    return Column(children: <Widget>[
      Container(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(5.0),
                onPressed: () {
                  _controller.animateToPage(0,
                      duration: new Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                },
                color: Color(0xFF00A0BE),
                textColor: Color(0xFFFFFFFF),
                child: Text('LOGIN',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 2.0)),
              ))),
      Container(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    _controller.animateToPage(2,
                        duration: new Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  },
                  color: Color(0x00000000),
                  textColor: Color(0xFF525252),
                  child: Text('SIGN UP',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12.0,
                          color: Color(0xFF525252),
                          letterSpacing: 2.0)))))
    ]);
  }
}

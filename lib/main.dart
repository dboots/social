import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Social/widgets/landing/landing.dart';
import 'package:Social/widgets/dashboard/dashboard.dart';
import 'package:Social/widgets/profile/profile.dart';

void main() {
	//debugPaintSizeEnabled=true;
	runApp(MyApp());
}

final ThemeData socialTheme = ThemeData(
    fontFamily: 'Lato'
);

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: socialTheme,
            routes: _routes()
        );
    }

    _routes() {
        return <String, WidgetBuilder>{
            '/' : (BuildContext context) => LandingPage(),
						'dashboard': (BuildContext context) => DashboardPage(),
						'profile': (BuildContext context) => ProfilePage()
        };
    }
}

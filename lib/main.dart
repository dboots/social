import 'package:flutter/material.dart';
import 'package:social/widgets/landing.dart';

void main() => runApp(new MyApp());

final ThemeData socialTheme = new ThemeData(
    fontFamily: 'Lato'
);

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
            title: 'Flutter Demo',
            theme: socialTheme,
            routes: _routes()
        );
    }

    _routes() {
        return <String, WidgetBuilder>{
            '/'         : (BuildContext context) => new LandingPage()
        };
    }
}

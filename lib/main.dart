import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Social/widgets/landing/landing.dart';
import 'package:Social/widgets/dashboard/dashboard.dart';
import 'package:Social/widgets/profile/profile.dart';
import 'package:Social/widgets/landing/signup.dart';
import 'package:Social/widgets/cliques/cliques.dart';
import 'package:Social/widgets/camera/camera.dart';
import 'package:Social/widgets/cliques/friends/add-friend.dart';
import 'package:Social/widgets/profile/moments/moments.dart';

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
						'profile': (BuildContext context) => ProfilePage(),
                        'profile/moments': (BuildContext context) => MomentsPage(),
            'signup': (BuildContext context) => SignupPage(),
						'cliques': (BuildContext context) => CliquesPage(),
						'camera': (BuildContext context) => CameraPage(),
						'cliques/friends/add': (BuildContext context) => AddFriendPage(),
        };
    }
}

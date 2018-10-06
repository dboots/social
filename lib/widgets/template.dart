import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  Page() : super();

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }	

	_getBody() {
		return Scaffold(
			body: Container(
				decoration: new BoxDecoration(color: Colors.white),
				child: SafeArea(
					child: Container()
				)
			)
		);
	}
}
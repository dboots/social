import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String label;

  PageTitle({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25.0),
        child:
            Text(label, style: TextStyle(fontSize: 22.0, letterSpacing: 2.5)));
  }
}

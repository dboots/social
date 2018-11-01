import 'package:flutter/material.dart';

class LineItem extends StatelessWidget {
  final String label;
  final List<Widget> widgets;

  LineItem({this.label, this.widgets});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(children: _itemBody()),
    );
  }

  List<Widget> _itemBody() {
    List<Widget> bodyWidgets = [
      Container(
          padding: EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
              radius: 15.0,
              backgroundColor: Color(0xFF003300),
              child: Text(label.substring(0, 1),
                  style: TextStyle(color: Colors.white)))),
      Expanded(
        child: Text(label.toString().toUpperCase(),
            style: TextStyle(fontSize: 16.0, color: Color(0xFF666666))),
      )
    ];

		if (this.widgets != null) {
			bodyWidgets.addAll(this.widgets);
		}

		return bodyWidgets;
  }
}

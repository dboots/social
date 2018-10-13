import 'package:flutter/material.dart';
import 'package:Social/widgets/common/utils.dart';

class BottomNav extends StatelessWidget {
  final IconData leftIcon;
  final Function leftAction;
  final String middleLabel;
  final Function middleAction;
  final IconData rightIcon;
  final Function rightAction;

  BottomNav(
      {this.leftIcon,
      this.leftAction,
      this.middleLabel,
      this.middleAction,
      this.rightIcon,
      this.rightAction});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (leftAction != null && leftIcon != null) {
      widgets.add(Utils.getIconButton(0xFF666666, leftIcon, 20.0, leftAction));
    } else {
      widgets.add(Container(
          padding: EdgeInsets.all(11.0), margin: EdgeInsets.all(11.0)));
    }

    if (middleAction != null && middleLabel != null) {
      widgets.add(Expanded(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              alignment: Alignment.center,
              child: FlatButton(
                  shape: Border.all(width: 3.0, color: Color(0xFF666666)),
                  onPressed: middleAction,
                  child: Text(middleLabel,
                      style: TextStyle(
                          color: Color(0xFF666666), fontSize: 18.0))))));
    } else {
      widgets.add(Expanded(child: Container()));
    }

    if (rightAction != null && rightIcon != null) {
      widgets
          .add(Utils.getIconButton(0xFF666666, rightIcon, 20.0, rightAction));
    } else {
      widgets.add(Container(
          padding: EdgeInsets.all(11.0), margin: EdgeInsets.all(11.0)));
    }

    return Row(children: widgets);
  }
}

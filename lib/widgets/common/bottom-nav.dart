import 'package:flutter/material.dart';
import 'package:Social/widgets/common/utils.dart';

class BottomNav {
  Widget build(
      {String middleLabel,
      Function middleAction,
      IconData leftIcon,
      IconData rightIcon,
      Function leftAction,
      Function rightAction}) {
    List<Widget> widgets = [];

    if (leftAction != null && leftIcon != null) {
      widgets.add(
          Utils.getIconButton(0xFF666666, leftIcon, 20.0, leftAction));
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
    }

    if (rightAction != null && rightIcon != null) {
      widgets.add(
          Utils.getIconButton(0xFF666666, rightIcon, 20.0, rightAction));
    } else {
      widgets.add(Container(
          padding: EdgeInsets.all(11.0), margin: EdgeInsets.all(11.0)));
    }

    return Row(children: widgets);
  }
}

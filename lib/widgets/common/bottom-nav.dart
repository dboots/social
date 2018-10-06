import 'package:flutter/material.dart';
import 'package:Social/widgets/common/utils.dart';

class BottomNav {
  IconData leftIcon;
  Function leftAction;

  String middleLabel;
  Function middleAction;

  IconData rightIcon;
  Function rightAction;

  BottomNav(
      {this.leftAction,
      this.rightAction,
      this.leftIcon,
      this.rightIcon,
      this.middleAction,
      this.middleLabel});

  Widget build() {
    return Row(children: <Widget>[
      Utils.getIconButton(0xFF666666, leftIcon, 20.0, 11.0, leftAction),
      Expanded(
          child: FractionallySizedBox(
              widthFactor: 0.6,
              alignment: Alignment.center,
              child: FlatButton(
                  shape: Border.all(width: 3.0, color: Color(0xFF666666)),
                  onPressed: middleAction,
                  child: Text(middleLabel,
                      style: TextStyle(
                          color: Color(0xFF666666), fontSize: 18.0))))),
      Utils.getIconButton(0xFF666666, rightIcon, 20.0, 11.0, rightAction)
    ]);
  }
}

import 'package:flutter/material.dart';

class AlertOverlay {
  String title;
  String body;
  String buttonLabel;
	Function buttonAction;

  OverlayState overlayState;
  OverlayEntry overlayEntry;

  AlertOverlay({Key key, this.title, this.body, this.buttonLabel, this.buttonAction});

  void showOverlay(BuildContext context) {
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) => _getBody());

    overlayState.insert(overlayEntry);
  }

  Widget _getBody() {
    return Scaffold(
        backgroundColor: Color.fromARGB(125, 0, 0, 0),
        body: SizedBox.expand(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                alignment: FractionalOffset.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))),
                          child: Column(children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(title,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        letterSpacing: 3.0,
                                        color: Color.fromARGB(
                                            255, 125, 125, 125)))),
                            Text(body,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                    fontStyle: FontStyle.italic))
                          ])),
                      Container(
                          child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: FlatButton(
                                  onPressed: () {
																		if (buttonAction != null) {
																			buttonAction();
																		}
                                    overlayEntry.remove();
                                  },
                                  child: Text(buttonLabel,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        letterSpacing: 3.0,
                                        color: Colors.white,
                                      )))),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))))
                    ]))));
  }
}

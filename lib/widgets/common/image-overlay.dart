import 'package:flutter/material.dart';
import 'package:Social/widgets/common/utils.dart';

class ImageOverlay extends StatelessWidget {
  final String label;
  final String url;


  ImageOverlay({this.label, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.width) * 2 / 3,
      margin: EdgeInsets.only(top: 4.0, bottom: 2.0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0
          )
        ],
        borderRadius: BorderRadius.all(const Radius.circular(12.0))
      ),
      child: Stack(children: <Widget>[
        Utils.getImageBackground(url),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text(label,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24.0,
                  letterSpacing: 2.5,
                  color: Color(0xFF000000)
                ),
                textAlign: TextAlign.center
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text('JANUARY 14',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 14.0,
                  letterSpacing: 2.5,
                  color: Color(0xFF000000)
                ),
                textAlign: TextAlign.center
              )
            )
          ])
        )
      ])
    );
  }
}

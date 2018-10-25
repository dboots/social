import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';

class ReviewCard extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final String reviewDate;
  final String labelContent;

  ReviewCard({
    this.avatarUrl,
    this.userName,
    this.reviewDate,
    this.labelContent
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      margin: EdgeInsets.only(top: 4.0, bottom: 2.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0
          )
        ],
        borderRadius: BorderRadius.all(const Radius.circular(12.0))
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(avatarUrl)
              )
            )
          ),
          Expanded(
            child: Column(children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                  Text(userName,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18.0,
                      letterSpacing: 2.5,
                      color: Color(0xFF000000)
                    ),
                    textAlign: TextAlign.center
                  ),
                  Text(reviewDate,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                      letterSpacing: 2.5,
                      color: Color(0xFF000000)
                    ),
                    textAlign: TextAlign.center
                  )
                ])
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(labelContent,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14.0,
                    letterSpacing: 2.5,
                    color: Color(0xFF000000)
                  ),
                  textAlign: TextAlign.left
                )
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [ 
                  Utils.getIconButton(0xFF666666, FontAwesomeIcons.thumbsUp, 20.0, () {}),
                  Utils.getIconButton(0xFFFF0000, FontAwesomeIcons.heart, 20.0, () {})
                ])
              )
          ])
        )]
      )
    );
  }
}

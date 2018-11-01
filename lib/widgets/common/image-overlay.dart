import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:Social/widgets/common/utils.dart';

class ImageOverlay extends StatelessWidget {
  final String label;
  final String url;


  ImageOverlay({this.label, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenViewWrapper(
              imageProvider: AssetImage(url),
              heroTag: label,
            ),
          )
        );
      },
      child: Container(
        child: Hero(
          tag: label,
          child: Container(
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
          )
        )
      )
    );
  }
}

class FullScreenViewWrapper extends StatelessWidget {
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Color backgroundColor;
  final dynamic minScale;
  final dynamic maxScale;
  final String heroTag;

  const FullScreenViewWrapper(
    {
      this.imageProvider,
      this.loadingChild,
      this.backgroundColor,
      this.minScale,
      this.maxScale,
      this.heroTag
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingChild: loadingChild,
        backgroundColor: backgroundColor,
        minScale: minScale,
        maxScale: maxScale,
        heroTag: heroTag,
      )
    );
  }
}

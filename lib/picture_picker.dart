import 'dart:io';
import 'package:flutter/material.dart';

class PicturePicker extends StatelessWidget {
  final Function onTap;
  final File imageFile;
  final double width;
  final double height;
  final IconData icon;
  final BoxShape shape;
  final String imageUrl;

  const PicturePicker({
    Key key,
    this.onTap,
    this.imageFile,
    this.icon,
    this.imageUrl,
    this.shape = BoxShape.circle,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius _radius = shape == BoxShape.circle
        ? BorderRadius.circular(width)
        : BorderRadius.circular(12);

    Widget _image;

    if (imageUrl != null && imageFile == null) {
      _image = buildUrlImage();
    } else if (imageFile != null) {
      _image = buildFileImage();
    } else {
      _image = buildPlaceholderImage(context);
    }

    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            shape: shape,
            borderRadius: shape == BoxShape.rectangle ? _radius : null,
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                offset: Offset(0.0, 16.0),
                blurRadius: 30.0,
              ),
            ],
            border: Border.all(
              width: 4.0,
              color: Theme.of(context).backgroundColor,
            )),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              borderRadius: _radius,
              child: InkWell(
                highlightColor: Colors.transparent,
                borderRadius: _radius,
                child: _image,
                onTap: onTap,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(width),
                    border: Border.all(
                      width: 3.0,
                      color: Theme.of(context).backgroundColor,
                    )),
                child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: onTap,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFileImage() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: this.shape == BoxShape.circle
            ? BorderRadius.circular(this.width)
            : BorderRadius.circular(12),
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildUrlImage() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: this.shape == BoxShape.circle
            ? BorderRadius.circular(this.width)
            : BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildPlaceholderImage(BuildContext context) {
    return Center(
        child: Image.asset(
      'assets/img/pokeball.png',
      fit: BoxFit.contain,
    ));
  }
}

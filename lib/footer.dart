import 'dart:io';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? 28 : 0),
          child: Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.caption,
                      children: [
                        TextSpan(text: 'Built with '),
                        TextSpan(
                            text: 'passion',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                )),
                        TextSpan(
                          text: ' by Andrés Sanabria',
                        ),
                      ]))),
        ));
  }
}

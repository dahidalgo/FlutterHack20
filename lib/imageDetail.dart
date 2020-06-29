import 'package:flutter/material.dart';

class IdeasDetail extends StatefulWidget {
  final String image;

  IdeasDetail(this.image);

  @override
  _IdeasDetailState createState() => _IdeasDetailState();
}

class _IdeasDetailState extends State<IdeasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[600],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 12,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Image.asset(widget.image),
          ),
        ),
      ),
    );
  }
}

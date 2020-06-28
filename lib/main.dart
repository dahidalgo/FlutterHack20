import 'package:flutter/material.dart';
import 'package:hack20/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterHack20',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'NotoSans',
      ),
      home: Home(),
    );
  }
}

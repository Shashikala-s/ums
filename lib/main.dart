import 'package:flutter/material.dart';
import 'package:ums/Splash.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: new ThemeData(
    brightness: Brightness.light,
    // accentColor: Colors.grey[400],
    // cursorColor: Colors.deepPurpleAccent[100],
    primaryColor: Colors.grey[300],

    // new
  ),
      home: ums(),
    ));

class ums extends StatefulWidget {
  @override
  _umsState createState() => _umsState();
}

class _umsState extends State<ums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: SplashPage(),
      body: splash(),

    );
  }



}

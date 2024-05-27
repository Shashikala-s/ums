import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ums/Request/token.dart';
import 'package:ums/Toast.dart';
import 'package:ums/network_connection.dart';


import '../Login.dart';

void main() => runApp(MaterialApp(
  home: splash(),
));

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    Token_request oo=Token_request();
    oo.getDetails();
    // TODO: implement initState
    super.initState();
   network_connection().check_connection(context);
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return LoginClass();
            })));



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

//          Image.asset('assests/image.png'),
          SpinKitFadingCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.grey : Colors.purple[600],
                ),
              );
            },
          ),
//          Loading(
//            size: 200,
//
//            indicator: BallPulseIndicator(),
//          )
        ],
      ),
    );
  }



//  void test () async{
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile) {
//      print('MOBILE');
//      Timer(
//          Duration(seconds: 2),
//              () => Navigator.pushReplacement(context,
//              MaterialPageRoute(builder: (BuildContext context) {
//                return LoginClass();
//              })));
//    } else if (connectivityResult == ConnectivityResult.wifi) {
//      print('WI-FI');
//      Timer(
//          Duration(seconds: 2),
//              () => Navigator.pushReplacement(context,
//              MaterialPageRoute(builder: (BuildContext context) {
//                return LoginClass();
//              })));
//    } else {
//      Toast_msg innt = Toast_msg();
//      innt.networkerror(context, 'Unable to connect. Please Check Internet Connection');
//    }
//  }


}

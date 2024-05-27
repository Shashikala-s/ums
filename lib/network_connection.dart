import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ums/Toast.dart';

class network_connection {
  void check_connection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
//      print('MOBILE');
//      Timer(
//          Duration(seconds: 2),
//          () => Navigator.pushReplacement(context,6
//                  MaterialPageRoute(builder: (BuildContext context) {
//                return LoginClass();
//              })));
    } else if (connectivityResult == ConnectivityResult.wifi) {
//      print('WI-FI');
//      Timer(
//          Duration(seconds: 2),
//          () => Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (BuildContext context) {
//                return LoginClass();
//              })));
    } else {
      Toast_msg innt = Toast_msg();
      innt.networkerror(
          context, 'Unable to connect. Please Check Internet Connection');
    }
  }
}

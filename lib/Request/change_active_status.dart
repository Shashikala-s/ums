import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class change_active_status {
  String? hd_user, action, act, user;
  // String hd_user, action, act, user;
  Map? details;
  List? res2;
  var context;
  bool? success;
  String? msg;

  change_active_status({required this.action,required this.user, this.context});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token')??"";

    if (action != null && user != null) {
      final pref = await SharedPreferences.getInstance();
      hd_user = pref.getString('Username')??"";

      if (action == 'ACTIVATE') {
        act = '1';
//        print('USER_DETAILS---' +
//            action +
//            '--' +
//            user +
//            '--' +
//            act +
//            '--' +
//            hd_user);
        Response response = await post(
            'http://192.168.1.234:83//api/v1/Mobile/UserMaintain' as Uri,
            body: {
              '_user': '$user',
              '_action': '$action',
              '_act': '$act',
              '_create': '$hd_user',
            },
            headers: {
              HttpHeaders.authorizationHeader: token
            });
        var dataresponse = jsonDecode((response.body));
        details = jsonDecode(dataresponse);
        success = details!['Success'];
         msg = details!['Message'];
//        print(success);
//        print(details);
//        if (success == true) {
//          Toast_msg ins = Toast_msg();
//          ins.showAlertDialogsuccess(context, 'Active status: ' + msg);
//        } else {
//          Toast_msg ins = Toast_msg();
//          ins.showAlertDialog(context, msg);
//        }
      }
    } else {
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context,'Incorrect user id');
    }
  }
}

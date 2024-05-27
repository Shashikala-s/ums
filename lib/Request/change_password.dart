import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class change_password {
  String? user, action, act, hd_user;
  Map? details;
  List? res2;
  bool? success;
  var context;
  String? msg;
  change_password({this.action, this.user, this.context});

  Future getDetails() async {
    final sf = await SharedPreferences.getInstance();
    var token = sf.getString('token');

    if (action != null && user != null) {
      if (action == 'RESET_PW') {
        final pref = await SharedPreferences.getInstance();
        hd_user = pref.getString('Username');
        act = '1';
        Response response = await post(
            'http://192.168.1.234:83//api/v1/Mobile/UserMaintain' as Uri,
            body: {
              '_user': '$user',
              '_action': '$action',
              '_act': '$act',
              '_create': '$hd_user',
            },
            headers: {
              HttpHeaders.authorizationHeader: token??""
            });

        var dataresponse = jsonDecode((response.body));
//        print(dataresponse);
        details = jsonDecode(dataresponse);
         success = details!['Success'];
         msg = details!['Message'];

//        print(details);
//        print('changepw_:$success');

//        if (success == true) {
////          pr.close();
//          Toast_msg ins = Toast_msg();
//          ins.showAlertDialogsuccess(context, 'Password: ' + msg);
//        } else {
////          pr.close();
//          Toast_msg ins = Toast_msg();
//          ins.showAlertDialog(context, msg);
//        }
      }
    } else {
//      pr.close();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context,'Please check userid');
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class reset_data {
  String? user, action, action2, act, hd_user;
  Map? details;
  List? res2;
  int? pw_sucess, active_sucess;
  var context;
  var token;
  var error_msg_pw, error_msg_active;

  //  ProgressDialog pr;

  reset_data({this.action, this.action2, this.user, this.context});

  Future getDetails() async {
    final sf = await SharedPreferences.getInstance();
    token = sf.getString('token');
    hd_user = sf.getString('Username');
    act = '1';

    if (action == 'RESET_PW' && action2 == 'ACTIVATE') {
      reset_pw();
      reset_active();
    } else if (action == 'RESET_PW') {
      reset_pw();
    } else if (action2 == 'ACTIVATE') {
      reset_active();
    }
    getUserOrder();
  }

  Future<String?> getUserOrder() {
    // wait 5 sec  to get results
    return Future.delayed(Duration(seconds: 5), ()  {
      print('password and status successfully updated');
      if (pw_sucess == 1 && active_sucess == 1) {
        Toast_msg ins = Toast_msg();
        ins.showAlertDialog(
            context, "password and status successfully updated");

    //        context.pr.hide().then((isHidden) {
    //          print(isHidden);
    //        });

      } else if (pw_sucess == 1) {
        Toast_msg ins = Toast_msg();
        ins.showAlertDialog(context, "password  successfully updated");

    //        pr.hide();
      } else if (active_sucess == 1) {
        Toast_msg ins = Toast_msg();
        ins.showAlertDialog(context, "status successfully updated");

    //        pr.hide();
      } else {
        Toast_msg ins = Toast_msg();
        ins.networkerror(context, "please try again");
        context.pr.hide();
      }
    });
  }

  void reset_pw() async {
    //    pr.hide();
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
    //    print(dataresponse);
    details = jsonDecode(dataresponse);
    bool success1 = details!['Success'];
    String msg = details!['Message'];
    //    print('changepw_:$success1');

    if (success1 == true) {
      pw_sucess = 1;
    } else {
      error_msg_pw = msg;
      pw_sucess = 2;
    }
  }

  void reset_active() async {
    //    pr.hide();
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
    bool success = details!['Success'];
    String msg = details!['Message'];

    if (success == true) {
      active_sucess = 1;
    } else {
      error_msg_active = msg;
      active_sucess = 2;
    }
  }
}

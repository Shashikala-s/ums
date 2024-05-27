import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class Logout_request {
  String? username, sessionid, companyname;
  String? res;
  Map? logoutdata;
  var res2;
  var context;

  Logout_request(
      {this.username, this.sessionid, this.companyname, this.context});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token')??"";

    if (username != null && sessionid != null && companyname != null) {
      Response response =
          await post('http://192.168.1.234:83//api/v1/Mobile/ExitLogin' as Uri, body: {
        'UserID': '$username',
        'Comp': '$companyname',
        'SessionID': '$sessionid'
      }, headers: {
        HttpHeaders.authorizationHeader: token
      });

      var dataresponse = jsonDecode((response.body));
      logoutdata = jsonDecode(dataresponse);
    } else {
      Toast_msg ins = Toast_msg();
      ins.empty_field(context);
    }
  }
}

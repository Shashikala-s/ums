import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class reset_password {
  String? username, password, newpassword;
  String? res;
  Map? company;
  var res2, context;

  reset_password(
      {this.username, this.newpassword, this.password, this.context});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token')??"";
//    print(username + "--" + password + "--" + newpassword);
    if (username != null && newpassword != null && password != null) {
      Response response = await post(
          'http://192.168.1.234:83//api/v1/Mobile/ChangePassword' as Uri,
          body: {
            '_user': '$username',
            '_newPw': '$newpassword',
            '_oldPw': '$password'
          },
          headers: {
            HttpHeaders.authorizationHeader: token
          });

      var dataresponse = jsonDecode((response.body));
      company = jsonDecode(dataresponse);
    } else {
      Toast_msg ins = Toast_msg();
      ins.empty_field(context);
    }
  }
}

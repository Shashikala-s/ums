import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/Toast.dart';

class Search_request {
  String? username, password, companyname;
  String? res;
  Map? company;
  var res2, context;

  Search_request({required this.username, this.context});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token')??"";
//    print(username);
    if (username != null) {
      Response response = await post(
          'http://192.168.1.234:83//api/v1/Mobile/GetUserDetail' as Uri,
          body: {
            'user': '$username',
          },
          headers: {
            HttpHeaders.authorizationHeader: token
          });

      var dataresponse = jsonDecode((response.body));
      company = jsonDecode(dataresponse);
      res2 = company!['Data'];
    } else {
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, 'User id empty');
    }
  }
}

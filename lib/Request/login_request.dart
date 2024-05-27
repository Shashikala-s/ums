import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_request {
  String? username, password, companyname;
  String? res;
  Map? company;
  var res2, context;

  Login_request({required this.username, required this.password, required this.companyname, this.context});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String? token = sf.getString('token');

//    print('LOG TOKEN'+token);
    Response response = await post(
        'http://192.168.1.234:83//api/v1/Mobile/GetAuthentication' as Uri,
        body: {
          '_userid': '$username',
          '_pw': '$password',
          '_com': '$companyname',
          '_verNo': 'Training-10',
          '_ipAddress': '192.168.1.1',
          '_hostName': 'localhost',
          '_inAttempts': '1',
        },
        headers: {
          HttpHeaders.authorizationHeader: token??""
        });

    var dataresponse = jsonDecode((response.body));
    print('LOGIN REQ + $dataresponse');
    company = jsonDecode(dataresponse);
    res2 = company!['Data'];

//    } else {
//      Toast_msg ins = Toast_msg();
//      ins.empty_field(context);
//    }
  }
}

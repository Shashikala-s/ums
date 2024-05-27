import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Company_request {
  String? username ,res;
  Map? company;
  List? res2;

  Company_request({this.username});

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token')??"";
    Response response = await post(
        'http://192.168.1.234:83//api/v1/Mobile/GetUserCompany' as Uri,
        body: {
          'username': '$username',
        },
        headers: {
          HttpHeaders.authorizationHeader: token
        });

    var dataresponse = jsonDecode((response.body));
    print(dataresponse);
    company = jsonDecode(dataresponse);
    res2 = company!['Data'];
  }
}

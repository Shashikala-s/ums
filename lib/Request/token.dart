import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token_request {
  Token_request();

  void getDetails() async {
    final sf = await SharedPreferences.getInstance();

    Response response = await post('http://192.168.1.234:83/token' as Uri, body: {
      'client_id': 'service_app',
      'client_secret': '3ac94887-3fcf-4ea4-8815-9543cae4a349',
      'grant_type': 'client_credentials',
    }, headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    });
    var dataresponse = jsonDecode((response.body));
    var token = dataresponse['access_token'];
//    print(token);
    token = 'bearer '+token;
    sf.setString('token', token);
  }
}

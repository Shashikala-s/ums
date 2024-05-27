import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:ums/Resetpassword.dart';
import 'package:ums/Toast.dart';
import 'package:ums/User.dart';
import 'package:ums/network_connection.dart';

import '/Request/company_request.dart';
import '/Request/login_request.dart';

class LoginClass extends StatefulWidget {
  @override
  _LoginClassState createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  late ProgressDialog pr;
  late Response response;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

//  final companyController = TextEditingController();
  Set<String> listdata = {"A", "B"};
  String? _mySelection = null;
  late String username, password, companyname;

  @override
  void initState() {
    check_status();
    network_connection().check_connection(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // try {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/ic_launcher.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: TextField(
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          onChanged: (String User) {
                            setState(() {
                              listdata.clear();
                              setupCompany();
                              username = usernameController.text;
                            });
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                            suffixIcon:  Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0),),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                                size: MediaQuery.sizeOf(context).height * 0.04,
                              ),
                            ),
                              contentPadding: const EdgeInsets.all(0),
                              hintText: 'username'.toUpperCase(),
                              hintStyle: TextStyle(
                                  fontSize: MediaQuery.sizeOf(context).height *
                                      0.022),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  // strokeAlign: 2,
                                  width: 2.0,
                                  color: Colors.grey[200] ?? Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  // strokeAlign: 2,
                                  width: 2.0,
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  // strokeAlign: 2,
                                  width: 2.0,
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: TextField(
                          maxLines: 1,
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          controller: passwordController,
                          onChanged: (String data) {
                            setState(() {
                              password = passwordController.text;
                            });
                          },
                          decoration: InputDecoration(
                              suffixIcon:  Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),),
                                child: Icon(
                                  Icons.enhanced_encryption,
                                  color: Colors.black,
                                  size: MediaQuery.sizeOf(context).height * 0.04,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              hintText: 'password'.toUpperCase(),
                              hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.022,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    // strokeAlign: 2,
                                    width: 2.0,
                                    color: Colors.grey[200] ?? Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    // strokeAlign: 2,
                                    width: 2.0,
                                    color: Colors.grey[400] ?? Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    // strokeAlign: 2,
                                    width: 2.0,
                                    color: Colors.grey[400] ?? Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          listdata.clear();
                          setupCompany();
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.07,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.grey[200]??Colors.grey,
                              style: BorderStyle.solid,
                              width: 2.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: Text(
                                "Select Company".toUpperCase(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.022,
                                    color: Colors.grey[700]),
                              ),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.022,
                              ),
                              value: _mySelection,
                              onChanged: (v) {
                                _mySelection = v!;
                                setState(() {
                                  _mySelection;
                                });
                              },
                              items: listdata.map((String data) {
                                return DropdownMenuItem<String>(
                                  value: data,
                                  child: Text(data,
                                      style: TextStyle(
                                          fontSize: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.022,
                                          color: Colors.black)),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).height * 0.5,
                        child: FloatingActionButton.extended(
                          elevation: 0,
                          backgroundColor: Colors.black,
                          onPressed: () {
                            setState(() {
                              loginAuth();
                            });
                          },
                          label: Text(
                            'Login'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.025,
                                fontWeight: FontWeight.w800),
                          ),
                          icon: Icon(
                            color: Colors.white,
                            Icons.home,
                            size: MediaQuery.sizeOf(context).height * 0.04,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                             ),
                          ),
                        ),
                      ),
                      Container(
                        child: TextButton.icon(
                          onPressed: () {
                            pr = ProgressDialog(context: context);
                            pr = ProgressDialog(
                              context: context,
                            );
                            pr.show();
                            //                  Navigator.pop(context, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => resetpassword()),
                            );
                          },
                          label:  Text(
                            'Reset Password ',
                            style: TextStyle(
                              fontSize: MediaQuery.sizeOf(context).height * 0.025,
                              color: Color.fromRGBO(160, 148, 171, 1),
                            ),
                          ),
                          icon:  Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.purple[800],
                              borderRadius: BorderRadius.circular(30.0),),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.change_circle_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.sizeOf(context).height * 0.03,
                                ),
                              ],
                            ),
                          ),
                                                    ),
                        ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ) ??
        SizedBox.shrink();
    ;
    // } catch (e) {
    //
    //   Toast_msg ins = Toast_msg();
    //   ins.showToast(context!);
    // }
  }

  void check_status() async {
    final pref = await SharedPreferences.getInstance();
    final login = pref.getBool('Login');
    print('loginSF --- $login');

    if (login == true) {
//      Navigator.pop(context,true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => user()),
      );
//      Navigator.push(context, MaterialPageRoute(builder: (context) => user()))
//      Navigator.pop(context);
    }
  }

//   void loginAuth() async {
//     username = usernameController.text;
//     password = passwordController.text;
// //    print('DETAILS' + _mySelection);
//
//     if (username.isNotEmpty && password.isNotEmpty && _mySelection != null) {
//       pr = ProgressDialog(context: context);
//       pr = ProgressDialog(
//         context: context,
//
//         // type: ProgressDialogType.Normal,
//         // isDismissible: true,
//         // showLogs: false
//       );
//       pr.show();
//       final pref = await SharedPreferences.getInstance();
//       var success, session_id, login;
//       var company;
//
//       Login_request instance = Login_request(
//
//           // get details form function
//           username: username,
//           password: password,
//           companyname: _mySelection,
//           context: context);
//
//       // await instance.getDetails();
//
//       company = instance.company;
// //    print(company);
//       if (company != null) {
//         success = company['Success'];
//         pref.setString("Username", username);
//         pref.setString("Company", _mySelection ?? "");
// //    print(success);
//         if (success == true) {
//           login = company['Login'];
// //      print('login --- $login');
//           session_id =
//               company['Data']['User_session_id']; //print(company['Data']);
//           pref.setBool("Login", login);
//           pref.setBool("Success", success);
//           pref.setString("User_session_id", session_id);
//
//           Navigator.pop(context, true);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => user()),
//           );
//         } else {
//           pr.close();
// //          var msg = company['Message'];
//           Toast_msg ins = Toast_msg();
//           ins.showAlertDialog(context, 'Invalid password');
// //      ins.showToast_msg(msg);
//         }
//       } else {
//         pr.close();
//       }
//     } else if (username.isEmpty && password.isEmpty && _mySelection == null) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(
//           context, "username , password and company name  empty");
//     } else if (username.isEmpty && password.isEmpty) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, "username and password   empty");
//     } else if (password.isEmpty && _mySelection == null) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, " password and company name  empty");
//     } else if (username.isEmpty && _mySelection == null) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, "username  and company name  empty");
//     } else if (username.isEmpty) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, "username empty");
//     } else if (password.isEmpty) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, "password empty");
//     } else if (_mySelection == null) {
//       Toast_msg ins = Toast_msg();
//       ins.showAlertDialog(context, "company name empty");
//     }
//   }
  void loginAuth() async {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => user()),
          );

  }

  void setupCompany() async {
    //  listdata.clear();
//    _mySelection = null;
//    companyController.clear();
    print('USERNAME--' + usernameController.text);
    Company_request? instance =
        Company_request(username: usernameController.text);
    // await instance.getDetails();

    Map? company;
    List res2;
    String types;

    company = instance.company;
    res2 = company!['Data'];
    if (res2 != null) {
      for (var a = 0; a < res2.length; a++) {
        types = res2[a]['companyCode'];
        setState(() {
          listdata.add(types);
        });
      }
    }
  }
}

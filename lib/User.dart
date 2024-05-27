import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:ums/Login.dart';
import 'package:ums/Option_menu/Constants.dart';
import 'package:ums/Request/change_active_status.dart';
import 'package:ums/Request/change_password.dart';
import 'package:ums/Request/logout_request.dart';
import 'package:ums/Request/search_request.dart';
import 'package:ums/Toast.dart';

class user extends StatefulWidget {
  final Widget? child;

  user({ this.child}) : super();

  @override
  _userState createState() => _userState();
}

class _userState extends State<user> with WidgetsBindingObserver {
  bool _value = false;
  ProgressDialog? pr;
  String fullname = 'name', email = 'email';
  bool _radiovalue = false;
  var searchtext_txt;

  final searchcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print('init-user');
    lastlog();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      var now = new DateTime.now();
//      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
//    print(now);
      final pref = await SharedPreferences.getInstance();
      pref.setString("lastlog", now.toString());
      print('now to string' + now.toString());
    }
//    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
//    print(now);
    void onChange(bool value) {
      //change switch
      setState(() {
        _value = value;
//        print(value);
      });
    }

    void onChange_radiobtn(bool value) {
//      change radio btn
      setState(() {
        _radiovalue = value;
        print(value);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceselection,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        title: Text(
          'USER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[400],
        elevation: 0,
//        backgroundColor: Color.fromRGBO(33, 71, 117, 1),
//        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.deepPurple,
                    style: BorderStyle.solid,
                    width: 1.0),
              ),
              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
//flex: 2,
                    child: Container(
                      child: TextField(
                        onChanged: (String search) {
//                          setState(() {
//
//                          });
                        },
                        controller: searchcontroller,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration.collapsed(
                          hintText: 'search',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 65,
                    child: FloatingActionButton.extended(
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.purple[700],
                        ), //`Icon` to display
                        label: Text(''), //`Text` to display
                        onPressed: () {
                          setState(() {
                            search_user();
                          });

//                          setState(() {
//                            if (_state == 0) {
//                              animateButton();
//                            }
//                          });
                        }),
                  ),
                ],
              ),
            ),
//            Padding(
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
//                          color: Color.fromRGBO(33, 71, 117, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                      textAlign: TextAlign.left,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '$fullname',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0))),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Email',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
//                            color: Color.fromRGBO(33, 71, 117, 1),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                      textAlign: TextAlign.left,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '$email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0))),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Unlock',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
//                            color: Color.fromRGBO(33, 71, 117, 1),
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Center(
                      child: Checkbox(
                        onChanged: (bool? val) {
                          onChange_radiobtn(val!);
                        },
                        value: _radiovalue,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Change password',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
//                            color: Color.fromRGBO(33, 71, 117, 1),
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Column(
                      children: <Widget>[
                        new Switch(
                          onChanged: (bool value) {
                            onChange(value);
                          },
                          value: _value,
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
//            Container(
//              child: new ProgressIndicator(
//
//              )
//            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
//                  height: 45,
                  // margin: const EdgeInsets.fromLTRB((0), 30, 0, 0),
                  child: FloatingActionButton.extended(
                    // padding: const EdgeInsets.all(12),
//                color: Colors.purple[800],
//                     color: Colors.white,
                    onPressed: () {
                      submit_details();
                    },
                    label: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                    icon: Icon(Icons.directions),
                    // textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
//                  height: 45,
                  // margin: const EdgeInsets.fromLTRB((0), 30, 0, 0),
                  child: FloatingActionButton.extended(
                    // padding: const EdgeInsets.all(12),
//                color: Colors.purple[800],
//                    color: Color.fromRGBO(99, 57, 116, 1),
//                     color: Colors.grey,
                    onPressed: () {
                      clear();
                    },
                    label: Text(
                      'Clear',
                      style: TextStyle(fontSize: 18),
                    ),
                    icon: Icon(Icons.directions),
                    // textColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //option menu..............................
  Future choiceselection(String choice) async {
//    print('CHOICE $choice');
    final pref = await SharedPreferences.getInstance();
    final session_id = pref.getString('User_session_id');
    final username = pref.getString('Username');
    final company = pref.getString('Company');
    if (choice == 'Logout') {
//      print('LOGOUT'+session_id + '--' + username + '--' + company);
      Logout_request instance = Logout_request(
          username: username, companyname: company, sessionid: session_id);
      //await instance.getDetails();
//      print('INSTANCE' + (instance.logoutdata).toString());
      if ((instance.logoutdata) != null) {
        pref.setBool('Login', false);
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => LoginClass()),
//        );

        Navigator.pop(context, true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginClass()),
        );
      } else {
        showToast();
      }
    }
  }

  void showToast() {
    Toast_msg init = Toast_msg();
    init.showAlertDialog(context, 'Error:Please try again !');
  }

  void showToast_empty() {
    Toast_msg ins = Toast_msg();
    ins.empty_field(context);
  }

  Future search_user() async {
    searchtext_txt = searchcontroller.text;
    String searchtext = searchtext_txt;

    if (searchtext.isEmpty) {
//      print('check:searchempty2');
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, 'User id empty');
      pr?.close();
    } else {
//       print('check:searchempty');
      pr = new ProgressDialog(context:context);
      pr = new ProgressDialog(context: context,
          // type: ProgressDialogType.Normal,
          // isDismissible: true,
          // showLogs: false
      );
      pr?.show();
      //print(searchtext);
      //print('else');
      Search_request instance = Search_request(username: searchtext);
      // await instance.getDetails();
      var res2 = instance.company;
      var data = res2!['Data'];
      // print(data);
      if (data != null) {
        bool success = res2['Success'];
        // print('SUCESSS'+success.toString());
        if (success == true) {
          String user = data['Se_usr_name'];
          String mail = data['se_Email'];
          //int Se_act = data['Se_act'];
          setState(() {
            //progress......................................
            // pr.close.then((isHidden) {
          //           print(isHidden);
          //   });
            //progress end ...................................

            fullname = user;
            email = mail;
          });
          //  print(user);
          //print(user);
        } else {
          setState(() {
            pr?.close();
            fullname = '';
            email = '';
            _value = false;
            _radiovalue = false;
          });
          Toast_msg ins = Toast_msg();
          ins.showAlertDialog(context, 'Incorrect user id');
        }
      } else {
        pr?.close();
        //String msg = data['Message'];
        Toast_msg ins = Toast_msg();
        ins.showAlertDialog(context, 'Incorrect user id');
      }
    }
  }

  Future submit_details() async {
    var pw_success, active_success;
    var pw_success_msg, active_success_msg;

    var searchvalue = searchtext_txt;

    if (searchvalue.isNotEmpty) {
//      print('search value not empty'+searchvalue);
      pr = new ProgressDialog(context: context);
      pr = new ProgressDialog(context: context,
          // type: ProgressDialogType.Normal,
          // isDismissible: true,
          // showLogs: false
      );
      pr?.show();
      if (_value == true) {
        change_password instance = change_password(
            action: 'RESET_PW', user: searchtext_txt, context: context);
        //await instance.getDetails();

//        print(instance.details);

        if (instance.success == true) {
          pw_success = 1;
        } else {
          pw_success = 2;
          pw_success_msg = instance.msg;
        }
      }
      if (_radiovalue == true) {
        change_active_status instance = change_active_status(
            action: 'ACTIVATE', user: searchtext_txt, context: context);
        //await instance.getDetails();

        if (instance.success == true) {
          active_success = 1;
        } else {
          active_success = 2;
          active_success_msg = instance.msg;
        }
//        print(instance.details);
      }

      Future.delayed(Duration(seconds: 2), () {
        pr?.close();
        clear();
        Toast_msg ins = Toast_msg();
        if (active_success == 1 && pw_success == 1) {
          ins.showAlertDialogsuccess(
              context, 'password and status successfully updated');
        } else if (active_success == 1) {
          ins.showAlertDialogsuccess(context, 'status successfully updated');
        } else if (pw_success == 1) {
          ins.showAlertDialogsuccess(context, 'password  successfully updated');
        } else if (active_success == 2 && pw_success == 2) {
          ins.showAlertDialogsuccess(
              context, active_success_msg + '   ' + pw_success_msg);
        } else if (active_success == 2) {
          ins.showAlertDialogsuccess(context, active_success_msg);
        } else if (pw_success == 2) {
          ins.showAlertDialogsuccess(context, pw_success_msg);
        }
      });
    } else {
      pr?.close();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, 'Required userid and action');
    }
  }

  void lastlog() async {
    pr = new ProgressDialog(context: context);
    pr = new ProgressDialog(context: context,
        // type: ProgressDialogType.Normal, isDismissible: true, showLogs: false
    );
    pr?.show();
    final pref = await SharedPreferences.getInstance();
    String? time = pref.getString('lastlog');
    final sessionid = pref.getString('User_session_id');
    //final login = pref.getString('Login');
    final username = pref.getString('Username');
    final companyname = pref.getString('Company');

    if (time != null) {
      var now = new DateTime.now();

      var date02 = DateTime.parse(time);
      Duration difference = now.difference(date02);

      if (difference.inHours > 23) {
        //print('MORE THAN 1 MIN'+difference.inMinutes.toString());
        //print('DIFFERENCE'+now.toString()+'---'+time);
        //aftre 24 hrs logout start
        Logout_request instance = Logout_request(
            username: username, companyname: companyname, sessionid: sessionid);
        //await instance.getDetails();
        //instance.logoutdata;
        //print(instance.logoutdata);
        if ((instance.logoutdata) != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginClass()),
          );
        } else {
          Toast_msg ins = Toast_msg();
          ins.showToast(context);
        }
        //aftre 24 hrs logout end
      }
    }
  }

  void clear() {
    setState(() {
      searchtext_txt = '';
      fullname = '';
      email = '';
      searchcontroller.clear();
      _value = false;
      _radiovalue = false;
    });
  }
}

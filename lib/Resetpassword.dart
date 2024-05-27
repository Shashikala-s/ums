import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:ums/Login.dart';
import 'package:ums/Request/reset_password.dart';
import 'package:ums/Toast.dart';
import 'package:ums/network_connection.dart';

class resetpassword extends StatefulWidget {
  @override
  _resetpasswordState createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  ProgressDialog? pr;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  late String username, oldpassword, newpassword;

  @override
  void initState() {
    network_connection().check_connection(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Reset password',
          style: TextStyle(color: Colors.white),
        ),

        backgroundColor: Colors.grey[400],

//        backgroundColor: Color.fromRGBO(33, 71, 117, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.account_circle,
                      size: 20,
                      color: Color.fromRGBO(245, 176, 65, 1),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'username',
                    hintStyle: TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
                textAlign: TextAlign.center,
                controller: usernameController,
                onChanged: (String data) {
                  username = usernameController.text;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.vpn_key, size: 20,
//                       color: Colors.purple[700],
                      color: Color.fromRGBO(245, 176, 65, 1),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'old password',
                    hintStyle: TextStyle(
                      fontSize: 17,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
                textAlign: TextAlign.center,
                controller: passwordController,
                onChanged: (String data) {
                  oldpassword = passwordController.text;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.vpn_key, size: 20,
//                      color: Colors.purple[800],
                      color: Color.fromRGBO(245, 176, 65, 1),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'new password',
                    hintStyle: TextStyle(
                      fontSize: 17,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
                textAlign: TextAlign.center,
                controller: confirmpasswordController,
                onChanged: (String data) {
                  newpassword = confirmpasswordController.text;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//              color: Color.fromRGBO(69, 112, 164, 1),
//              color: Colors.purple[800],
//               color: Color.fromRGBO(99, 57, 116, 1),
              onPressed: () {
                savePassword();
              },
              label: Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
              icon: Icon(Icons.directions),
              // textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savePassword() async {
//    newpassword=confirmpasswordController.text;
//    oldpassword=passwordController.text;
//    username=usernameController.text;
    if (username != null && newpassword != null && oldpassword != null) {
      pr = new ProgressDialog(context: context);
      pr = new ProgressDialog(context: context,
          // type: ProgressDialogType.Normal,
          // isDismissible: true,
          // showLogs: false
      );
      pr?.show();

      reset_password instance = reset_password(
        username: '$username',
        newpassword: '$newpassword',
        password: '$oldpassword',
      );
      //await instance.getDetails();
      var data = instance.company;
      bool success = data!['Success'];
      String msg = data!['Message'];
      if (success == true) {
        pr?.close();
        Toast_msg innt = Toast_msg();
        innt.showAlertDialogsuccess(context, msg);

        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context, true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginClass()),
          );
        });
      } else {
        pr?.close();
        //      print(msg);
        Toast_msg innt = Toast_msg();
        innt.showAlertDialog(context, msg);
      }
    } else if (username == null && newpassword == null && oldpassword == null) {
//      reset();

      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(
          context, "username , new password old password  empty");
    } else if (username == null && newpassword == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, "username and new password   empty");
    } else if (newpassword == null && oldpassword == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, " new password and old password  empty");
    } else if (username == null && oldpassword == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, "username and old password  empty");
    } else if (username == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, "username empty");
    } else if (newpassword == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, "new password empty");
    } else if (oldpassword == null) {
//      reset();
      Toast_msg ins = Toast_msg();
      ins.showAlertDialog(context, "old password empty");
    }
  }

//  void reset() {
//    username = null;
//    newpassword = null;
//    oldpassword = null;
//  }
}

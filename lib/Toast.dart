import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Toast_msg {
  void showToast(BuildContext context) {
    Alert(
      context: context,
      title: "Error",
      desc: 'Error : Please try again !',
    ).show();

//    Fluttertoast.showToast(
//      msg: 'Error : Please try again !',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.BOTTOM,
//      timeInSecForIos: 1,
//      fontSize: 20,
//      backgroundColor: Colors.grey[600],
//      textColor: Colors.white,
//    );
  }

  void showToast_msg(String msg) {
//    Fluttertoast.showToast(
//      msg: 'Error : $msg',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.BOTTOM,
//      timeInSecForIos: 1,
//      fontSize: 20,
//      backgroundColor: Colors.grey[600],
//      textColor: Colors.white,
//    );
  }

  void password_chenged(BuildContext context) {
    Alert(
      context: context,
      title: "Error",
      desc: 'Success : Password changed',
    ).show();

//    Fluttertoast.showToast(
//      msg: 'Success : Password changed',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.BOTTOM,
//      timeInSecForIos: 1,
//      fontSize: 20,
//      backgroundColor: Colors.grey[600],
//      textColor: Colors.white,
//    );
  }

  void empty_field(BuildContext context) {
    Alert(
      context: context,
      title: "Error",
      desc: 'Error : Text field empty !',
    ).show();
  }

  showAlertDialog(BuildContext context, String msg) {
    Alert(
      context: context,
      title: "Error",
      desc: msg,
    ).show();
  }

  showAlertDialogsuccess(BuildContext context, String msg) {
    Alert(
      context: context,
      title: "Success",
      desc: msg,
    ).show();
  }

  networkerror(BuildContext context, String msg) {
    Alert(
      context: context,
      title: "Error",
      desc: msg,
    ).show();
  }
}

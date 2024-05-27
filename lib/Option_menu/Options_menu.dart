import 'package:flutter/material.dart';
import 'package:ums/Option_menu/Constants.dart';

//NOT IMPORTANT.....
class options_menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Option menu"),
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
      ),
    );
  }

  void choiceselection(String choice) {
    if (choice == 'Logout') {
//      print('Logout');
    }
  }


}

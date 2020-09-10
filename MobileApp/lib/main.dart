// import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_ui_login/leave_search.dart';
import 'package:flutter_ui_login/leave_list.dart';
import 'package:flutter_ui_login/leavesPage.dart';
import 'package:flutter_ui_login/searchPageExp.dart';
import 'package:flutter_ui_login/sidemenu.dart';
// import 'package:flutter_ui_login/time.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ui_login/ExpenseSearch.dart';
import 'checkin.dart';
import 'home.dart';
import 'login.dart';
import 'contact.dart';

// import 'forgetPass.dart';
// import 'leave_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
                //     theme: ThemeData(
                //     primaryColor: Colors.pink,
                //     accentColor: Colors.purple,
                //     textTheme: TextTheme(body2: TextStyle(color: Colors.red)),
                // ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/checkin': (BuildContext context) => new CheckIn(id: null),
        '/home': (BuildContext context) => new HomePage(id: null),
        '/sidemenu': (BuildContext context) => new SideMenu(),
        '/contact': (BuildContext context) => new Contact(),
        '/leave': (BuildContext context) => new LeaveList(),
        '/find': (BuildContext context) => new ExpenseSearch(),
         '/searchPage': (BuildContext context) => new searchPage(id: null,dt_start: null,dt_end: null,),
         '/leaveSearch': (BuildContext context) => new LeaveSearchApp(),
         '/leaveSearchPage': (BuildContext context) => new leavesPage(id: null,start_date:null,end_date:null),
        // '/date': (BuildContext context) => new DateTimePicker(),
        // '/time': (BuildContext context) => new Time(),

      },
      home: new MyHomePage(),
    );
  }
}

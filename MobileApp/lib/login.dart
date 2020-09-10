import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home.dart';

// import 'forgetPass.dart';
// import 'leave_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String id = idController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'http://10.0.2.2/Test/login_user.php';

    // Store all data with Param Name.
    var data = {'id': id, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    // var message1 = jsonDecode(response1.body);

    // If the Response Message is Matched.
    if (message == 'Login Success') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Center(child: new Text("OK")),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to Profile Screen & Sending username to Next Screen.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(id: idController.text)));
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  Widget showLogo() {
    return Image.asset('assets/cubelogo.png');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
              child: Stack(
                children: <Widget>[
                  showLogo(),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          child: RaisedButton(
                            color: Colors.red,
                            onPressed: () {
                              userLogin();
                              // Navigator.of(context).pushNamed('/sidemenu');
                            },
                            child: Center(
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20.0),
                    // Container(
                    //   height: 40.0,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //     // decoration: BoxDecoration(
                    //     //     border: Border.all(
                    //     //         color: Colors.black,
                    //     //         style: BorderStyle.solid,
                    //     //         width: 1.5),
                    //     //     color: Colors.transparent),
                    //     child: RaisedButton(
                    //         color: Colors.blue,
                    //         onPressed: () {
                    //           Navigator.of(context).pushNamed('/forgetPass');
                    //         },
                    //         child: Center(
                    //           child: Text('forget password',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontFamily: 'Montserrat')),
                    //         )),
                    //   ),
                    // )
                  ],
                )),
            SizedBox(height: 15.0),
          ],
        ));
  }
}

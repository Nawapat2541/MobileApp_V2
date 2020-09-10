import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// import 'home.dart';

class CheckIn extends StatefulWidget {
  final String id;

  const CheckIn({Key key, this.id}) : super(key: key);

  @override
  _CheckInState createState() => _CheckInState(id);
}
class _CheckInState extends State<CheckIn> {
  bool visible = false;
  final String id;
  String _ip = 'Unknown';
  String _userAgent = '<unknown>';
  String _webUserAgent = '<unknown>';
  Future userCheckIn() async {
    String ipAddress;
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }
    if (!mounted) return;
    setState(() {
      _ip = ipAddress;
    });

    String userAgent, webViewUserAgent;
    try {
      userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
      await FlutterUserAgent.init();
      webViewUserAgent = FlutterUserAgent.webViewUserAgent;
    } on PlatformException {
      userAgent = webViewUserAgent = '<error>';
    }
    if (!mounted) return;
    setState(() {
      _userAgent = userAgent;
      _webUserAgent = webViewUserAgent;
    });

    setState(() {
      visible = true;
    });

    String workinghours = "0";
    String workHourType = "1";
    final String apiURL = 'http://10.0.2.2/Test/checkin.php';
    var data = {
      'id': id,
      'datetime': _datetimeString,
      'work_hour_type': workHourType,
      'workinghours': workinghours,
      'ip': _ip,
      'userAgent': _webUserAgent,
      'Agent': _userAgent
    };
    final response = await http.post(apiURL, body: json.encode(data));
    var message = jsonDecode(response.body);

    if (message == 'Checkin Success') {
      setState(() {
        visible = false;
      });
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             HomePage(id: id)
                    //             ));
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        visible = false;
      });
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

  Future userCheckOut() async {
    String ipAddress;
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }
    if (!mounted) return;
    setState(() {
      _ip = ipAddress;
    });

    String userAgent, webViewUserAgent;
    try {
      userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
      await FlutterUserAgent.init();
      webViewUserAgent = FlutterUserAgent.webViewUserAgent;
    } on PlatformException {
      userAgent = webViewUserAgent = '<error>';
    }
    if (!mounted) return;
    setState(() {
      _userAgent = userAgent;
      _webUserAgent = webViewUserAgent;
    });
    String workHourType = "2";
    final String apiURL = 'http://10.0.2.2/Test/checkout.php';
    var data = {
      'id': id,
      'datetime': _datetimeString,
      'work_hour_type': workHourType,
      'ip': _ip,
      'userAgent': _webUserAgent,
      'Agent': _userAgent
    };
    var response = await http.post(apiURL, body: json.encode(data));
    var message = jsonDecode(response.body);

    if (message == 'Checkout Success') {
      setState(() {
        visible = false;
      });
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             HomePage(id: id)
                    //             ));
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        visible = false;
      });
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

  String date = "";
  String time = "";

  String _timeString;
  String _datetimeString;
  String _dateString;

  String _date;
  String _month;
  String _year;

  int d;
  int m;
  int y;

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    final String formattedTime = _formatTime(now);
    final String formattedDate = _formatDate(now);

    final String formattedDay = _formatDay(now);
    final String formattedMonth = _formatMonth(now);
    final String formattedYear = _formatYear(now);

    // var parsedDate = formattedDateTime;

    if (mounted) {
      setState(() {
        _timeString = formattedTime;
        _datetimeString = formattedDateTime;
        _dateString = formattedDate;

        _date = formattedDay;
        _month = formattedMonth;
        _year = formattedYear;

        d = int.parse(_date);
        m = int.parse(_month);
        y = int.parse(_year);
      });
    }
  }

  String _formatDay(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  String _formatMonth(DateTime dateTime) {
    return DateFormat('MM').format(dateTime);
  }

  String _formatYear(DateTime dateTime) {
    return DateFormat('yyyy').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE  dd  MMMM  yyyy').format(dateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
  }

  _CheckInState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          //leading: Icon(Icons.devices),
          title: Text(
            "CHECK IN / CHECK OUT ",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                child: Center(
                  child: Text(' Welcome ',
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ),
            ),
            Center(
              child: Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(id,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5.0)),
                  //   elevation: 4.0,
                  //   onPressed: () {
                  //     // DatePicker.showTimePicker(context,
                  //     //     theme: DatePickerTheme(
                  //     //       containerHeight: 210.0,
                  //     //     ),
                  //     //     showTitleActions: true, onConfirm: (time) {
                  //     //   print('confirm $time');
                  //     //   time = '${time.hour} : ${time.minute} : ${time.second}' as DateTime;
                  //     //   setState(() {});
                  //     // }, currentTime: DateTime.now(), locale: LocaleType.en);
                  //     // setState(() {});
                  //   },
                  Container(
                    //child:
                    alignment: Alignment.center,
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 80.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " $_timeString",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 65.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //color: Colors.teal[400],
                  //)
                  SizedBox(
                    height: 15.0,
                  ),
                  // RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5.0)),
                  //   elevation: 4.0,
                  //   onPressed: () {
                  //     // DatePicker.showDatePicker(context,
                  //     //     theme: DatePickerTheme(
                  //     //       containerHeight: 210.0,
                  //     //     ),
                  //     //     showTitleActions: true,
                  //     //     minTime: DateTime(2017, 1, 1), //2017, 1, 1
                  //     //     maxTime: DateTime(y, m, d), onConfirm: (date) { //2022, 12, 31
                  //     //   print('confirm $date');
                  //     //   date = '${date.day} - ${date.month} - ${date.year}' as DateTime; //${date.year} - ${date.month} - ${date.day}
                  //     //   setState(() {});
                  //     // }, currentTime: DateTime.now(), locale: LocaleType.en);
                  //   },
                  Container(
                    //child:
                    alignment: Alignment.center,
                    height: 80.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 45.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " $_dateString",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //color: Colors.teal[400],
                  // ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.teal[400],
                        color: Colors.teal[400],
                        elevation: 7.0,
                        child: GestureDetector(
                          child: RaisedButton(
                            color: Colors.teal[400],
                            onPressed: () {
                              userCheckIn();
                            },
                            child: Center(
                              child: Text('Check In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.red[700],
                        color: Colors.red[700],
                        elevation: 7.0,
                        child: GestureDetector(
                          child: RaisedButton(
                            color: Colors.red[700],
                            onPressed: () {
                              userCheckOut();
                            },
                            child: Center(
                              child: Text('Check Out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// import 'package:intl/intl.dart';
// import 'dart:async';

// class DateTimePicker extends StatefulWidget {
//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {

//   String _timeString;
//   String _datetimeString;
//   String _dateString;

//   String _date;
//   String _month;
//   String _year;

//   int d ;
//   int m;
//   int y;

//   @override
//   void initState() {
//     _timeString = _formatTime(DateTime.now());
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//     super.initState();
//   }
//   void _getTime() {
//     final DateTime now = DateTime.now();
//     final String formattedDateTime = _formatDateTime(now);
//     final String formattedTime = _formatTime(now);
//     final String formattedDate = _formatDate(now);

//     final String formattedDay = _formatDay(now);
//     final String formattedMonth = _formatMonth(now);
//     final String formattedYear = _formatYear(now);


//     setState(() {
//       _timeString = formattedTime;
//       _datetimeString = formattedDateTime;
//       _dateString = formattedDate;

//       _date = formattedDay;
//       _month = formattedMonth;
//       _year = formattedYear;

//       d = int.parse(_date);
//       m = int.parse(_month);
//       y = int.parse(_year);

//     });
//   }
  
//   String _formatDay(DateTime dateTime){
//     return DateFormat('dd').format(dateTime);
//   }
//   String _formatMonth(DateTime dateTime){
//     return DateFormat('MM').format(dateTime);
//   }
//   String _formatYear(DateTime dateTime){
//     return DateFormat('yyyy').format(dateTime);
//   }

//   String _formatTime(DateTime dateTime){
//     return DateFormat('hh:mm:ss').format(dateTime);
//   }

//   String _formatDate(DateTime dateTime){
//     return DateFormat('EEEE  dd  MMMM  yyyy').format(dateTime);
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('EEEE/MMMM/yyyy hh:mm:ss').format(dateTime);
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DateTime Picker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//                 elevation: 4.0,
//                 onPressed: () {
//                   DatePicker.showDatePicker(context,
//                       theme: DatePickerTheme(
//                         containerHeight: 210.0,
//                       ),
//                       showTitleActions: true,
//                       minTime: DateTime(2017, 1, 1), //2017, 1, 1
//                       maxTime: DateTime(y, m, d), onConfirm: (date) { //2022, 12, 31
//                     print('confirm $date');
//                     _dateString = '${date.day} - ${date.month} - ${date.year}'; //${date.year} - ${date.month} - ${date.day}
//                     setState(() {});
//                   }, currentTime: DateTime.now(), locale: LocaleType.en);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 50.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.date_range,
//                                   size: 18.0,
//                                   color: Colors.teal,
//                                 ),
//                                 Text(
//                                   " $_dateString",
//                                   style: TextStyle(
//                                       color: Colors.teal,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18.0),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "  Change",
//                         style: TextStyle(
//                             color: Colors.teal,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0),
//                       ),
//                     ],
//                   ),
//                 ),
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               RaisedButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//                 elevation: 4.0,
//                 onPressed: () {
//                   DatePicker.showTimePicker(context,
//                       theme: DatePickerTheme(
//                         containerHeight: 210.0,
//                       ),
//                       showTitleActions: true, onConfirm: (time) {
//                     print('confirm $time');
//                     _timeString = '${time.hour} : ${time.minute} : ${time.second}';
//                     setState(() {});
//                   }, currentTime: DateTime.now(), locale: LocaleType.en);
//                   setState(() {});
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 50.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.access_time,
//                                   size: 18.0,
//                                   color: Colors.teal,
//                                 ),
//                                 Text(
//                                   " $_timeString",
//                                   style: TextStyle(
//                                       color: Colors.teal,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18.0),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "  Change",
//                         style: TextStyle(
//                             color: Colors.teal,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0),
//                       ),
//                     ],
//                   ),
//                 ),
//                 color: Colors.white,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class Time extends StatefulWidget {
// //   @override
// //   _TimeState createState() => _TimeState();
// // }

// // class _TimeState extends State<Time> {
// //   String _timeString;
// //   String _datetimeString;
// //   String _dateString;

// //   @override
// //   void initState() {
// //     _timeString = _formatTime(DateTime.now());
// //     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Time"),
// //       ),
// //       body: Center(
// //         child: Text(_timeString ),
// //       ),
// //     );
// //   }

// //   void _getTime() {
// //     final DateTime now = DateTime.now();
// //     final String formattedDateTime = _formatDateTime(now);
// //     final String formattedTime = _formatTime(now);
// //     final String formattedDate = _formatDate(now);
// //     setState(() {
// //       _timeString = formattedTime;
// //       _datetimeString = formattedDateTime;
// //       _dateString = formattedDate;

// //     });
// //   }
  
// //   String _formatTime(DateTime dateTime){
// //     return DateFormat('hh:mm:ss').format(dateTime);
// //   }

// //   String _formatDate(DateTime dateTime){
// //     return DateFormat('hh:mm:ss').format(dateTime);
// //   }

// //   String _formatDateTime(DateTime dateTime) {
// //     return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
// //   }
// // }

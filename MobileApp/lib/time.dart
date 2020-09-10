// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';

// class Time extends StatefulWidget {
//   @override
//   _TimeState createState() => _TimeState();
// }

// class _TimeState extends State<Time> {
//   String _timeString;
//   String _datetimeString;
//   String _dateString;

//   @override
//   void initState() {
//     _timeString = _formatTime(DateTime.now());
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Time"),
//       ),
//       body: Center(
//         child: Text(_timeString ),
//       ),
//     );
//   }

//   void _getTime() {
//     final DateTime now = DateTime.now();
//     final String formattedDateTime = _formatDateTime(now);
//     final String formattedTime = _formatTime(now);
//     final String formattedDate = _formatDate(now);
//     setState(() {
//       _timeString = formattedTime;
//       _datetimeString = formattedDateTime;
//       _dateString = formattedDate;

//     });
//   }
  
//   String _formatTime(DateTime dateTime){
//     return DateFormat('hh:mm:ss').format(dateTime);
//   }

//   String _formatDate(DateTime dateTime){
//     return DateFormat('dd/MM/yyyy').format(dateTime);
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
//   }
// }

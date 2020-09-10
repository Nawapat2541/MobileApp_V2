import 'dart:ffi';

import 'package:intl/intl.dart';

class LeaveData {
  String userID, reason, description, startDate, endDate, leaveTypeName;
  int leaveID, leaveTypeId;
  int noDay;

  LeaveData({this.leaveID, this.userID, this.leaveTypeId, this.reason, this.description, this.startDate, this.endDate, this.noDay, this.leaveTypeName});

  factory LeaveData.fromJson(Map<String, dynamic> json) => LeaveData(
    leaveID: json['leave_id'],
    userID: json['user_id'] == null ? null : json["user_id"],
    startDate: json['start_date'] == null ? null : json["start_date"],
    endDate: json['end_date'] == null ? null : json["end_date"],
    leaveTypeId: json['leave_type_id'] == null ? null : json["leave_type_id"],
    reason: json['reason'] == null ? null : json["reason"],
    description: json['description'] == null ? null : json["description"],
    noDay: json['no_day'],
    leaveTypeName: json['leave_type_name'],
  );

  Map<String, dynamic> toJson() => {
    "leaveID" : leaveID,
    "userID": userID == null ? null : userID,
    "startDate": startDate == null ? null : startDate,
    "endDate": endDate == null ? null : endDate,
    "leaveTypeId": leaveTypeId,
    "reason": reason == null ? null : userID,
    "description": description == null ? null : userID,
    "noDay": noDay,
    "leaveTypeName": leaveTypeName,
  };
  
}
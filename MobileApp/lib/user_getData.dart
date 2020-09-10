class UserData {
  String userID;

  UserData({this.userID});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userID: json['id']
  );

  Map<String, dynamic> toJson() => {
    "userID" : userID
  };
  
}
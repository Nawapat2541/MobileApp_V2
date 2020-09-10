import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui_login/leave_getData.dart';
import 'package:http/http.dart' as http;

class leavesPage extends StatefulWidget {
  final String id;
  final DateTime start_date;
  final DateTime end_date;

  const leavesPage({Key key, this.id,this.start_date,this.end_date}) : super(key: key);

  @override
  _leavesPageState createState() => _leavesPageState(id,start_date,end_date);
}

class _leavesPageState extends State<leavesPage> {
  final String id;
  final DateTime start_date;
  final DateTime end_date;

  _leavesPageState(this.id,this.start_date,this.end_date);
  
final String url = 'http://10.0.2.2/Test/searchLeaves.php';

  Future<List<LeaveData>> fetchLeave() async {

    var data = {'id': id,'start_date': start_date.toString(),'end_date': end_date.toString() };
    var response = await http.post(url, body: json.encode(data));


    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<LeaveData> leaveList = items.map<LeaveData>((json) {
        return LeaveData.fromJson(json);
      }).toList();

      return leaveList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  navigateToNextActivity(BuildContext context, int dataHolder) {
    Navigator.of(context).push(MaterialPageRoute(
       builder: (context) => SecondScreenState(dataHolder.toString())));
  }
  
     @override
  void initState() {
    super.initState();
    // this.fetchLeave();
    this.fetchLeave();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
              title: Text("Leave " + id.toString()
              ),
              backgroundColor: Colors.deepPurple[300],
         ),
        body: FutureBuilder<List<LeaveData>>(
              future: fetchLeave(),
              builder: (context, snapshot) {
  if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
              
                       return ListView(
              
          children: snapshot.data.map((data) => Column(
            
            children: <Widget>[     

                      GestureDetector(               
                        onTap: () {
                          
                          navigateToNextActivity(context, data.leaveID);
                        },               
                        child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                    child: Row(children: <Widget>[
                                      Icon(Icons.account_circle,color: Colors.deepPurple[300]),
                                      //Text("ID:",style: new TextStyle(fontSize: 30.0),),
                                      Text(" " + data.leaveID.toString(),style: new TextStyle(fontSize: 30.0),),Spacer(),
                                    ]),),
                                    Padding(
                                    padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                    child: Row(children: <Widget>[
                                      Text(data.userID.toString()),
                                    ]),),
                                    Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                                    child: Row(children: <Widget>[
                                           Spacer(),
                                            Text("Start date : " + data.startDate.toString().split(" ")[0],style: new TextStyle(fontSize: 20.0),),
                                    ]),),
                                    Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                                    child: Row(children: <Widget>[
                                           Spacer(),
                                            Text("End date : " + data.endDate.toString().split(" ")[0],style: new TextStyle(fontSize: 20.0),),
                                    ]),)                                          
                                  
                                ]
                              ),
                              
                              ),
                        ),
                      ),
                      Divider(color: Colors.black),
                    ],
                  ))
              .toList(),
        );
              },
        ),
      );
  }
}

class SecondScreenState extends StatefulWidget {
  final String idHolder;
  SecondScreenState(this.idHolder);
  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder);
  }
}

class SecondScreen extends State<SecondScreenState> {
  final String idHolder;

  SecondScreen(this.idHolder);

  // API URL
  var url = 'http://10.0.2.2/Test/GetLeave.php';
  


  Future<List<LeaveData>> fetchLeave() async {
    var data = {'id': int.parse(idHolder)};

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<LeaveData> leaveList = items.map<LeaveData>((json) {
        return LeaveData.fromJson(json);
      }).toList();

      return leaveList;
    } else {
      throw Exception('Failed to load Data from Server.');
    }
  }

  // Widget registerButton2() {
  //   return IconButton(
  //     icon: Icon(Icons.format_list_bulleted),
  //     onPressed: () {
  //       print("You Click Leave");
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Showing Leave Details'),
        backgroundColor: Colors.deepPurple[300],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        // actions: <Widget>[registerButton2()],
      ),
      body: FutureBuilder<List<LeaveData>>(
        future: fetchLeave(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((data) => Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print(data.leaveID);
                          },
                              child: new Column(
                                children: <Widget>[

                                  new ListTile(
                                    leading: new Icon(
                                      Icons.account_circle,
                                      color: Colors.deepPurple[300],
                                      size: 26.0,
                                    ),
                                    title: new Text(
                                      "User name : " + data.userID.toString()
                                    ),
                                    subtitle: new Text(
                                      "Id : " + data.leaveID.toString()
                                    ),
                                  ),new Divider(color: Colors.deepPurple[300]),

                                  new ListTile(
                                    leading: new Icon(
                                      Icons.keyboard_tab,
                                      color: Colors.deepPurple[300],
                                    ),
                                    title: new Text(
                                      "Leave type"
                                    ),
                                    subtitle: Text(
                                      data.leaveTypeName.toString()
                                    ),
                                  ),new Divider(color: Colors.deepPurple[300]),
                                  
                                  new ListTile(
                                     leading: new Icon(
                                      Icons.av_timer,
                                      color: Colors.deepPurple[300],
                                    ),
                                    title: new Text(
                                      "Leave time"
                                    ),
                                    subtitle: Text(
                                      (data.noDay ~/ 1).toString() + " d" + " - " + ((data.noDay % 1) * 8).toString() + " h"
                                    ),
                                  ),new Divider(color: Colors.deepPurple[300]),

                                ]
                              ),
                          
                        )
                      ],
                    ))
                .toList(),
          );
        },
      ),
                         bottomNavigationBar: BottomNavigationBar(
               backgroundColor: Colors.grey[850],
                items: [
                      BottomNavigationBarItem(

                        
                        icon: Icon(Icons.home,color: Colors.grey),
                        title: Text("Home",style : TextStyle(color: Colors.grey)),
                        backgroundColor: Colors.redAccent,
                    ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.monetization_on,color: Colors.deepPurple),
                        title: Text("Leave",style : TextStyle(color: Colors.deepPurple)),
                        backgroundColor: Colors.deepPurple[700]
                    ),
                ],
              onTap: (index) {
                  if(index == 0){
                        Navigator.of(context).pushNamed('/home');      
                  }else if(index ==1){
                        // Navigator.of(context).pushNamed('/contact'); 
                  }else if(index ==2){
                              
                  }
                },
                ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Expensedata {
  int expenseID;
  int amount;
  String fromLocation;
  String toLocation;
  String userId;
  String description;
  String startDate;
  String endDate;

  Expensedata({
    this.expenseID,
    this.amount,
    this.fromLocation,
    this.toLocation,
    this.userId,
    this.description,
    this.startDate,
    this.endDate
  });

  factory Expensedata.fromJson(Map<String, dynamic> json) {
    return Expensedata(
      expenseID: json['expense_id'],
      amount: json['amount'],
      fromLocation: json['from_location'],
      toLocation: json['to_location'],
      userId: json['user_id'],
      description: json['description'],
      startDate: json['dt_start'],
      endDate: json['dt_end']
    );
  }
}

class searchPage extends StatefulWidget {
  final String id;
  final DateTime dt_start;
  final DateTime dt_end;

  const searchPage({Key key, this.id, this.dt_start, this.dt_end}) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState(id,dt_start,dt_end);
}

class _searchPageState extends State<searchPage> {
  final String id;
  final DateTime dt_start;
  final DateTime dt_end;

  // final String apiURL = 'http://10.0.2.2/Test/Expense_List.php';

  _searchPageState(this.id,this.dt_start,this.dt_end);

 Future<List<Expensedata>> fetchID() async {
    final String url = 'http://10.0.2.2/Test/searchIDexp.php';
    
    var data = {'id': id,'dt_start': dt_start.toString(),'dt_end' : dt_end.toString()};
    var response = await http.post(url, body: json.encode(data));

      if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Expensedata> studentList = items.map<Expensedata>((json) {
        return Expensedata.fromJson(json);
      }).toList();

      return studentList;
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
    // this.fetchExpense();
    this.fetchID();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Expense " + id.toString()
         ),
         backgroundColor: Colors.orange[300],
      ),
      body: FutureBuilder<List<Expensedata>>(
      future: fetchID(),
      builder: (context, snapshot) {

        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

           return ListView(
              
                   children: snapshot.data.map((data) => Column(
            
            children: <Widget>[     
                      GestureDetector(    
                         onTap: () {
                          navigateToNextActivity(context, data.expenseID);
                        },                       
                        child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                           
                                 children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                    child: Row(children: <Widget>[
                                      Icon(Icons.account_circle,color: Colors.orange[300]),
                                      //Text("ID:",style: new TextStyle(fontSize: 30.0),),
                                      Text(" " + data.expenseID.toString(),style: new TextStyle(fontSize: 30.0),),Spacer(), 
                                    ]),),
                                    Padding(
                                    padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                    child: Row(children: <Widget>[
                                      Text(data.userId.toString()),
                                    ]),),
                                    Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                                    child: Row(children: <Widget>[
                                           Spacer(),
                                            Text(data.amount.toString(),style: new TextStyle(fontSize: 20.0),),
                                            Text(" bath",style: new TextStyle(fontSize: 20.0)),
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
                        floatingActionButton: FloatingActionButton(onPressed: (){
                     Navigator.of(context).pushNamed('/find');
                    },child: Icon(Icons.search),backgroundColor: Colors.orange[300],),);
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
  var url = 'http://10.0.2.2/Test/GetExpense.php';
  


  Future<List<Expensedata>> fetchExpense() async {
    var data = {'id': int.parse(idHolder)};

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Expensedata> studentList = items.map<Expensedata>((json) {
        return Expensedata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Showing Expense Details'),
        backgroundColor: Colors.orange[300],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        // actions: <Widget>[registerButton2()],
      ),
      body: FutureBuilder<List<Expensedata>>(
        future: fetchExpense(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((data) => Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print(data.expenseID);
                          },
                              child: new Column(
                                children: <Widget>[

                                  new ListTile(
                                    leading: new Icon(
                                      Icons.account_circle,
                                      color: Colors.orange[300],
                                      size: 26.0,
                                    ),
                                    title: new Text(
                                      data.userId.toString()
                                    ),
                                    subtitle: new Text(
                                      data.expenseID.toString()
                                    ),
                                  ),new Divider(color: Colors.orange[300]),

                                  new ListTile(
                                    leading: new Icon(
                                      Icons.location_on,
                                      color: Colors.orange[300],
                                    ),
                                    title: new Text(
                                      "Strating Location"
                                    ),
                                    subtitle: Text(
                                      data.fromLocation.toString()
                                    ),
                                  ),new Divider(color: Colors.orange[300]),
                                  
                                  new ListTile(
                                     leading: new Icon(
                                      Icons.location_off,
                                      color: Colors.orange[300],
                                    ),
                                    title: new Text(
                                      "Destination Location"
                                    ),
                                    subtitle: Text(
                                      data.toLocation.toString()
                                    ),
                                  ),new Divider(color: Colors.orange[300]),

                                  new ListTile(
                                     leading: new Icon(
                                      Icons.monetization_on,
                                      color: Colors.orange[300],
                                    ),
                                    title: new Text(
                                      "Amount"
                                    ),
                                    subtitle: Text(
                                      data.amount.toString() + " bath"
                                    ),
                                  ),new Divider(color: Colors.orange[300]),

                                  new ListTile(
                                     leading: new Icon(
                                      Icons.comment,
                                      color: Colors.orange[300],
                                    ),
                                    title: new Text(
                                      "Description"
                                    ),
                                    subtitle: Text(
                                      data.description.toString()
                                    ),
                                  ),new Divider(color: Colors.orange[300]),

                                  new ListTile(
                                     leading: new Icon(
                                      Icons.date_range,
                                      color: Colors.orange[300],
                                    ),
                                    title: new Text(
                                      "Date"
                                    ),
                                    subtitle: new Text(
                                      data.startDate.toString() + "       " +data.endDate.toString()
                                    ),
                                  ),new Divider(color: Colors.orange[300])
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
                        icon: Icon(Icons.monetization_on,color: Colors.blueAccent),
                        title: Text("Expense",style : TextStyle(color: Colors.blueAccent)),
                        backgroundColor: Colors.yellow
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
// class searchPage extends StatelessWidget {

//    final String id;

//   const searchPage({Key key, this.id}) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//  return Scaffold(
//       appBar: AppBar(
//         title: Text("Expense " + id.toString()),
//         backgroundColor: Colors.orange[300],
      
//       ),
//       body: ShowView(),
    
//     );
//   }
// }

// class Expensedata {
//   int expenseID;
//   int amount;
//   String fromLocation;
//   String toLocation;
//   String userId;
//   String description;
//   String startDate;
//   String endDate;

//   Expensedata({
//     this.expenseID,
//     this.amount,
//     this.fromLocation,
//     this.toLocation,
//     this.userId,
//     this.description,
//     this.startDate,
//     this.endDate
//   });

//   factory Expensedata.fromJson(Map<String, dynamic> json) {
//     return Expensedata(
//       expenseID: json['expense_id'],
//       amount: json['amount'],
//       fromLocation: json['from_location'],
//       toLocation: json['to_location'],
//       userId: json['user_id'],
//       description: json['description'],
//       startDate: json['dt_start'],
//       endDate: json['dt_end']
//     );
//   }
// }

// class ShowView extends StatefulWidget {
//  final String id;

//   const ShowView({Key key, this.id}) : super(key: key);

//   @override
//   _ShowViewState createState() => _ShowViewState(id);
// }

// class _ShowViewState extends State<ShowView> {
// final String id;
//   final String apiURL = 'http://10.0.2.2/Test/Expense_List.php';

//   _ShowViewState(this.id);


//   Future<List<Expensedata>> fetchExpense() async {
//     var response = await http.get(apiURL);

//     if (response.statusCode == 200) {
//       final items = json.decode(response.body).cast<Map<String, dynamic>>();

//       List<Expensedata> studentList = items.map<Expensedata>((json) {
//         return Expensedata.fromJson(json);
//       }).toList();

//       return studentList;
//     } else {
//       throw Exception('Failed to load data from Server.');
//     }
//   }  

//      @override
//   void initState() {
//     super.initState();
//     this.fetchExpense();
//   }

//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//        title: Text("Expense " + id.toString()),
//         backgroundColor: Colors.red[300],
//           ),
//         );
//   }

 
// }
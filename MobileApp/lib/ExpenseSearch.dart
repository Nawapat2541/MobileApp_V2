 
import 'dart:ffi';
import 'package:flutter_ui_login/contact.dart';
import 'package:flutter_ui_login/home.dart';
import 'package:flutter_ui_login/searchPageExp.dart';
import 'package:nice_button/nice_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
class ExpenseSearch extends StatefulWidget {
  
  @override
  _ExpenseSearchState createState() => _ExpenseSearchState();
}

class _ExpenseSearchState extends State<ExpenseSearch> {
  String _mySelection;
    DateTime dateTime;

   DateTime _dateTime;
   DateTime _dateTimeEnd;

   

  // final String url = "http://webmyls.com/php/getdata.php";
  final String url = "http://10.0.2.2/Test/getUer.php";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
var subColor = Color(0xFFF0F4F1), subbColor = Color(0xFF00911E);

  @override
  void initState() {
    super.initState();
    this.getSWData();
    // dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Search Expense"),
         backgroundColor: Colors.orange[300]
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                getName(),   
        

                SizedBox(height: 20),
               Text(_dateTime == null ? 'Nothing has been picked yet' : new DateFormat('yyyy-MM-dd').format(_dateTime),style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                
            NiceButton(
                  radius: 40,
                  padding: const EdgeInsets.all(5),
                  text: "Pick a start date",
                  icon: Icons.calendar_today,
                  gradientColors: [secondColor, firstColor],
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
                ).then((date) {
                     setState(() {
                    _dateTime = date;
                  });
                });
              },
              
            ),
            SizedBox(height: 20),
             Text(_dateTimeEnd == null ? 'Nothing has been picked yet' : new DateFormat('yyyy-MM-dd').format(_dateTimeEnd),style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            NiceButton(
            radius: 40,
            padding: const EdgeInsets.all(5),
            text: "Pick a end date",
            icon: Icons.calendar_today,
            gradientColors: [secondColor, firstColor],
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTimeEnd == null ? DateTime.now() : _dateTimeEnd,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
                ).then((date) {
                  setState(() {
                    _dateTimeEnd = date;
                  });
                });
              },
            ),

            SizedBox(height: 30),
            NiceButton(
            radius: 40,
            padding: const EdgeInsets.all(15),
            text: "submit",
            gradientColors: [subColor, subbColor],
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to Profile Screen & Sending username to Next Screen.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>searchPage(id: _mySelection,dt_start: _dateTime,dt_end: _dateTimeEnd,)));
                  },          
            ),            
                       
                          ],
          )
        )
      ),
    );
  }

  Widget getName(){
    return Container(
        child: new SearchableDropdown.single(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['id']),
              value: item['id'].toString(),
            );
          }).toList(),
          value: _mySelection,
          hint: "Select one",
          searchHint: "Select one",
          onChanged: (value) {
            setState(() {
              _mySelection = value;
            });
          },
          
          isExpanded: true,
        ),
    );
  }

 

}

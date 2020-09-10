import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'checkin.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  final String id;

  const HomePage({Key key, this.id}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _HomePageState(id);
  }
}

Widget registerButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      FontAwesomeIcons.signOutAlt,
      color: Colors.redAccent,
    ),
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    },
  );
}

class _HomePageState extends State<HomePage> {
  final String id;

  Size size;

  _HomePageState(this.id);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Icon(Icons.devices),
                    title: RichText(
                      text: new TextSpan(
                          style: new TextStyle(fontSize : 30, ),
                          children: <TextSpan>[
                            TextSpan(text: 'Cube',style: TextStyle(foreground: Paint() ..color = Colors.red)),
                            TextSpan(text: ' Softtech',style: TextStyle(fontSize: 25,foreground: Paint() ..color = Colors.white,)),
                          ],
                      ),),
        actions: <Widget>[registerButton(context)],
      ),
      //  bottomNavigationBar: CurvedNavigationBar(

      //       backgroundColor: Colors.grey[800],
      //       items: <Widget>[
      //         Icon(Icons.add, size: 30),
      //         Icon(Icons.list, size: 30),
      //         Icon(Icons.compare_arrows, size: 30),
      //       ],
      //       onTap: (index) {
      //         if(index == 0){
      //               // Navigator.of(context).pushNamed('/home');
      //         }else if(index ==1){

      //         }else if(index ==2){

      //         }
      //       },
      //     ),
      body: Stack(children: <Widget>[
        Container(
          child: CustomPaint(
            // painter: ShapesPainter(),
            child: Container(
              height: size.height / 2,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                createGridItem(0),
                createGridItem(1),
                createGridItem(2),
                createGridItem(3),
                // createGridItem(4),
              ],
            ),
          ),
        )
      ]),
              bottomNavigationBar: BottomNavigationBar(
               backgroundColor: Colors.grey[850],
                items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home,color: Colors.blueAccent,),
                        title: Text("Home",style : TextStyle(color: Colors.blueAccent)),
                        backgroundColor: Colors.grey[850],
                    ),
                   
                      BottomNavigationBarItem(
                        icon: Icon(Icons.monetization_on,color: Colors.grey),
                        title: Text("Expense",style : TextStyle(color: Colors.grey)),
                       backgroundColor: Colors.grey[850],
                    ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.contact_mail,color: Colors.grey,),
                        title: Text("Leave",style : TextStyle(color: Colors.grey)),
                    ),    
                      BottomNavigationBarItem(
                        icon: Icon(Icons.devices,color: Colors.grey,),
                        title: Text("Equipment",style : TextStyle(color: Colors.grey)),
                    ),                               
                ],
              onTap: (index) {
                  if(index == 0){
                        // Navigator.of(context).pushNamed('/home');      
                  }else if(index ==1){
                        Navigator.of(context).pushNamed('/contact'); 
                  }else if(index ==2){
                              
                  }else if(index ==3){
                              
                  }
                },
                ),
      // drawer: SideMenu(),
    );
  }

  Widget createGridItem(int position) {
    var color = Colors.white;
    var icondata = Icons.add;

    switch (position) {
      case 0:
        color = Colors.pinkAccent;
        icondata = Icons.access_time;
        break;
      case 1:
        color = Colors.deepPurple;
        icondata = Icons.contact_mail;
        break;
      case 2:
        color = Colors.orange[300];
        icondata = Icons.monetization_on;
        break;
      case 3:
        color = Colors.grey;
        icondata = Icons.devices;
        break;
      // case 4:
      //   color = Colors.green;
      //   icondata = Icons.devices;
      //   break;
    }

    // return Builder(builder: (BuildContext context) {

    if (position == 0) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckIn(id: id)));
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icondata,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Check In/Check Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else if (position == 1) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/leave');
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icondata,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Leaves",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else if (position == 2) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/contact');
              //  return IconButton(icon: Icon(Icons.payment),
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icondata,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Expense",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else if (position == 3) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            onTap: () {
                Navigator.of(context).pushNamed('/contact');
                //  return IconButton(icon: Icon(Icons.payment),

            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icondata,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Equipment",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    // else if (position == 4) {
    //   return Padding(
    //     padding:
    //         const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
    //     child: Card(
    //       elevation: 10,
    //       color: color,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(10)),
    //         side: BorderSide(color: Colors.white),
    //       ),
    //       child: InkWell(
    //         onTap: () {
    //             Navigator.of(context).pushNamed('/date');
    //             //  return IconButton(icon: Icon(Icons.payment),
    //         },
    //         child: Center(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Icon(
    //                 icondata,
    //                 size: 40,
    //                 color: Colors.white,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   "Date / Time",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // });
  }
}
// class ShapesPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     // set the paint color to be white
//     paint.color = Colors.white;
//     // Create a rectangle with size and width same as the canvas
//     var rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     // draw the rectangle using the paint
//     canvas.drawRect(rect, paint);
//     paint.color = Colors.greenAccent[400];
//     // create a path
//     var path = Path();
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, 0);
//     // close the path to form a bounded shape
//     path.close();
//     canvas.drawPath(path, paint);
//     /* // set the color property of the paint
//     paint.color = Colors.deepOrange;
//     // center of the canvas is (x,y) => (width/2, height/2)
//     var center = Offset(size.width / 2, size.height / 2);
//     // draw the circle with center having radius 75.0
//     canvas.drawCircle(center, 75.0, paint);*/
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

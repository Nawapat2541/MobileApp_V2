import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'contact.dart';
import 'login.dart';

class SideMenu extends StatelessWidget {
 
   

  //  User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage()));
  }

    @override
    Widget build(BuildContext context) {
        return Drawer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    UserAccountsDrawerHeader(
                        accountName: Text('AccountName'),
                        accountEmail: Text('email@example.com'),
                        currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://scontent.fbkk6-2.fna.fbcdn.net/v/t1.0-9/22815587_1693945807292082_5312200696026088798_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_eui2=AeHZv1T5FmRkiktOkdgrfhoNwBCaWv59sXfAEJpa_n2xd4qJD7LqfUUmczOc-r8m-nVAJbqMqL0zci0bXqMNfQ5o&_nc_ohc=PhOOxyc5HWEAX_meD8P&_nc_ht=scontent.fbkk6-2.fna&oh=41b4edc05cf6541a0e9dc6c57d97f5eb&oe=5EEB11FA"
                            ),
                            backgroundColor: Colors.white,
                        ),
                    ),
               
                    ListTile(
                        leading: Icon(FontAwesomeIcons.moneyCheck),
                        title: Text('Expense'),
                        
                        onTap: () {
                           
                                Navigator.of(context).pushNamed('/contact');                         
                            //  return IconButton(icon: Icon(Icons.payment),
                          
                        },
                        
                        
                    ),
                    Divider(),
                             Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: 
                                             RaisedButton(
                                               onPressed: () {
                                                logout(context);
                                               },
                                               color: Colors.red,
                                               textColor: Colors.white,
                                               child: Text(' LOGOUT '),
                                               
                                             ),

                        ),
                             
                    ),
                ],
            ),
        );
    }
}
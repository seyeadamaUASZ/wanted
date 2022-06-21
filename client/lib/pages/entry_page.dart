import 'dart:convert';

import 'package:client/annonces/annonces.dart';
import 'package:client/pages/addAnnonce.dart';
import 'package:client/screens/AnnonceScreen.dart';
import 'package:client/screens/homescreen.dart';
import 'package:client/screens/postscreen.dart';
import 'package:client/screens/profilescreen.dart';
import 'package:client/screens/search_screen.dart';
import 'package:client/services/networkhandler.dart';

import 'package:client/theme/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EntryPage extends StatefulWidget {
  EntryPage({Key? key,this.currenState=0}) : super(key: key);
  int currenState;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
   //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    
  NetWorkHandler netWorkHandler=NetWorkHandler();
  //int currentState = 0;
  final storage = FlutterSecureStorage();
  List<Widget> widgets=[
    AnnonceScreen(),
    SearchScreen(),
    PostScreen(),
    ProfileScreen(),    
  ];
  String? username;

  checkUserLogged()async{
    var username1 = await storage.read(key: "username");
    setState(() {
      username = username1;
    });
    
  }

  @override
  void initState() {
    super.initState();
    checkUserLogged();
  }
  
  List<String> titleString=["Les annonces publiées","Recherches","Annonces postées","Mon profil"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: Drawer(  
            child: ListView(  
              children: [
                DrawerHeader(child: Column(  
                  
                  children: [
                    CircleAvatar(  
                      backgroundColor: Colors.blue[200],
                      radius: 50,
                      backgroundImage: AssetImage("assets/profil.png"),
                    ),
                    Text("${username}"),
                  ],
                )
                
                ),
                ListTile(  
                   title: Text("Toutes les annonces"),
                   trailing: Icon(Icons.launch),
                    onTap: (){

                    },
                ),
                ListTile(
              title: Text("Paramétres"),
              trailing: Icon(Icons.settings),
              onTap: (){
                
              },
            ),

            ListTile(
              title: Text("Retours"),
              trailing: Icon(Icons.feedback),
              onTap: (){
                
              },
            ),

            ListTile(
              title: Text("A propos"),
              trailing: Icon(Icons.info_outline),
              onTap: (){
                
              },
            ),

            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.power_settings_new),
              onTap: logout,
            )

              ],
            ),
          ),
          appBar: AppBar(  
            backgroundColor: Colors.blue[200],
            title: Text(titleString[widget.currenState]),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
           

          },  icon: Icon(Icons.notifications)),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor:Colors.blue[200],
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAnnonce()));
            },
            child: Text("+",style: TextStyle(fontSize: 30),),
          ),
          bottomNavigationBar: BottomAppBar(  
            color: Colors.blue[200],
            shape: CircularNotchedRectangle(),
            notchMargin: 12,
            child: Container(  
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          widget.currenState=0;
                        });
                      },
                       icon: Icon(Icons.home),
                       iconSize: 35,
                       color: Colors.white,
                       ),
                       IconButton(
                      onPressed: (){
                        setState(() {
                          widget.currenState=1;
                        });
                      },
                       icon: Icon(Icons.search),
                       iconSize: 35,
                       color: Colors.white,
                       ),
                       IconButton(onPressed: (){
                         setState(() {
                           widget.currenState=2;
                         });
                       },
                        icon: Icon(Icons.list),
                        iconSize: 35,
                        color: Colors.white,
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            widget.currenState=3;
                          });
                        },
                         icon: Icon(Icons.person),
                          iconSize: 35,
                         color: Colors.white,
                         )
                  ],
                ),
              ),
            ),
          ),
          body:widgets[widget.currenState]
          //
          //
          

    );
  }

  void logout()async{
     await storage.delete(key: 'token');
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
  }
}



        
   
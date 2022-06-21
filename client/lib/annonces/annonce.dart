import 'package:client/services/networkhandler.dart';
import 'package:client/theme/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Annonce extends StatelessWidget {
  const Annonce({Key? key,required this.id,
  required this.title,
  required this.description,
  this.created_at,
  required this.networkHandler,
  required this.contact}) : super(key: key);
  final String id;
  final String title;
  final String description;
  final DateTime? created_at;
  final String contact;
  final NetWorkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.blue[200],
        centerTitle: true,
        title: Text(title),
        //leading: IconButton(),
      ),
      body: ListView(  
        children: [
          Container(
            margin: EdgeInsets.only(top:15),
            height: 360,
            width: MediaQuery.of(context).size.width,
            child: Card(  
              elevation: 8,
              child: Column( 
                children: [  
                  Container(   
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(  
                      image: DecorationImage( 
                        image:networkHandler.getImage(id),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text(title,
                    style: TextStyle(  
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.start, 
                    children: [  
                      Icon(
                        Icons.phone,
                        size: 20,
                        color: Colors.red,
                      ),
                      // SizedBox(width: 5,),
                      // Icon(  
                      //   Icons.message,
                      //   size: 18,
                      // ),
                       SizedBox(width: 5,),
                      Text(contact.toString(),
                       style: TextStyle(  
                         fontSize: 15,
                         color: Colors.green
                       ),
                      ),
                      SizedBox(width: 10,),
                      Text("disparu le :",style: TextStyle(  
                        fontStyle: FontStyle.italic
                      ),),

                       SizedBox(width: 15,),
                       Text(created_at!.toString())
                      // Icon(
                      //   Icons.share,
                      //   size: 18,
                      // ),
                      // SizedBox(width: 8,),
                      // Text(addBlogModel.share.toString(),
                      //  style: TextStyle(  
                      //    fontSize: 15
                      //  ),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(  
            height: 10,
          ),
          Container( 
            height: 260,
            width: MediaQuery.of(context).size.width, 
            child: Card(  
              elevation: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(  
              horizontal: 10,
              vertical:15
            ),
              child: Text(description),
              ),
            ),
          ),
          Container(  
             padding: EdgeInsets.only(top: 10,
             bottom: 20,left: 20,right: 20),
             decoration: BoxDecoration(  
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[200]

            ),
            child: InkWell(
              onTap: (){
                print("call phone ...");
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone,size: 16,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Lancer l'appel",style: TextStyle(  
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
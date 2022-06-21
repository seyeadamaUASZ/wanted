import 'dart:convert';

import 'package:client/annonces/post_annonce_modify.dart';
import 'package:client/services/networkhandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  NetWorkHandler netWorkHandler = NetWorkHandler();
  dynamic data;
  List<dynamic> listItems=[];
  bool circular = true;


  void fetchData() async{
    var response = await netWorkHandler.getAnnonces("annonce/getOwnAnnonce");
    setState(() {
      data = json.decode(response.body);
      listItems.addAll(data['data']);
      circular=false;
      //print(listItems);
    });
  }
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body:Container(  
        margin: EdgeInsets.only(top: 15),
        child: circular ? CircularProgressIndicator()
        : ListView.separated(
          separatorBuilder:(context, index) => Divider(height: 2,color: Colors.black,),
            itemCount: listItems.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ 
                        CircleAvatar(  
                          backgroundImage: netWorkHandler.getImage(listItems[index]['_id']),
                          radius: 30,
                        ),
                        SizedBox(width: 20,),
                        Text("${listItems[index]['title']}")
                      ],
                    ),
                    Text(listItems[index]['classee']==false ? "Cherché": "Trouvé",style: TextStyle(  
                         color: listItems[index]['classee']==false ? Colors.red : Colors.green)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      PostAnnonceModify(title: listItems[index]['title'],
                      id: listItems[index]['_id'],
                      classee: listItems[index]['classee'],
                      description: listItems[index]['description'],
                      )));
                    },
                     icon:Icon(Icons.edit))
                  ],
                ),
              );
            }, ),
      )
    );
  }
}
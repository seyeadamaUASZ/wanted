import 'dart:convert';

import 'package:client/annonces/annonce.dart';
import 'package:client/model/AddAnnonceModel.dart';
import 'package:client/services/networkhandler.dart';
import 'package:client/widgets/annonce_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Annonces extends StatefulWidget {
  Annonces({Key? key,this.url}) : super(key: key);
  String? url;

  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
   NetWorkHandler netWorkHandler = NetWorkHandler();
     dynamic data;
     List<dynamic> listItems = [];
     bool circular = true;

  void fetchData()async{
    var response = await netWorkHandler.getAnnonces(widget.url!);
    setState(() {
      data = json.decode(response.body);
      listItems.addAll(data['data']);
      circular=false;
      //print(listItems);
    });
   
    //print(data);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
   return circular ? CircularProgressIndicator() : ListView.separated(
     separatorBuilder: (context, index) => Divider(height: 2,color: Colors.black,),
      itemCount: listItems.length,
      itemBuilder: (context,index){
       return listItems.length >0 ? Column(  
         children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Annonce(id: listItems[index]['_id'], 
                title: listItems[index]['title'], 
                description: listItems[index]['description'], 
                created_at:  DateFormat("yyyy-MM-dd", "en_US").parse(listItems[index]['created_at'].toString()),  //DateTime.parse(listItems[index]['created_at'].toString()), //DateTime.parse(),
                networkHandler: netWorkHandler,
                  contact: listItems[index]['contact'])
                ));
            },
            child: AnnonceCard(  
              id: listItems[index]['_id'],
              title: listItems[index]['title'],
              classee: listItems[index]['classee'],
              description: listItems[index]['description'],
              netWorkHandler: netWorkHandler,
            ),
          ),
           SizedBox(
            height: 10,
           ),

            
         ],
       ):Center(child: Text("Pas de nouvelles annonces publiées"),) 
       ;
      }
      
      );
    // return listItems.length > 0 ? Column(  
    //   children: listItems.map((item)=>Column(  
    //     children: [
    //       InkWell(  
    //         onTap: (){

    //         },
    //         child: AnnonceCard(  
    //           id: item['_id'],
    //           title: item['title'],
    //           classee: item['classee'],
    //           netWorkHandler: netWorkHandler,
    //         ),
    //       ),
    //        SizedBox(
    //     height: 10,
    //   ),
    //     ],
    //   )).toList(),
    // ): Center(
    //   child: Text("Pas encore d'annonces publiée !!!"),
    // );

  }
}
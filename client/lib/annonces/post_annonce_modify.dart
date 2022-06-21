import 'dart:convert';

import 'package:client/services/networkhandler.dart';
import 'package:client/widgets/annonce_card.dart';
import 'package:client/widgets/customDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostAnnonceModify extends StatefulWidget {
  PostAnnonceModify(
      {Key? key,
      required this.title,
      required this.id,
      required this.classee,
      required this.description})
      : super(key: key);
  final String title;
  final String id;
  final bool classee;
  final String description;

  @override
  State<PostAnnonceModify> createState() => _PostAnnonceModifyState();
}

class _PostAnnonceModifyState extends State<PostAnnonceModify> {
  NetWorkHandler netWorkHandler = NetWorkHandler();
  bool isSwitched = false;
  dynamic data;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        elevation: 0,
        title: const Text(
          "Modifier l'annonce",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        Container(
          child: AnnonceCard(
            id: widget.id,
            title: widget.title,
            classee: widget.classee,
            description: widget.description,
            netWorkHandler: netWorkHandler,
          ),
        ),
        const SizedBox(height: 20,),
        const Text("Fermer l'annonce si la personne est retrouvée",
        style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold) ,
        ),

        SizedBox(height: 35,),
        Center(
          child: Container(
            width: 300,
            height: 60.0,
            decoration: BoxDecoration(  
              color: Colors.blue[200],
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(()async {
                  isSwitched = value;
                  print("value of variable ${isSwitched}");
                  if(isSwitched==true){
                    var response = await netWorkHandler.getAnnonces("annonce/classee/${widget.id}");
                    data = json.decode(response.body);
                    showDialog(
                     context: context,
                      builder: (BuildContext context) => CustomDialog(
                            title: "Success",
                            description:
                                "Mis à jour effectué avec succés!!!",
                            buttonText: "Ok",
                            currentNavigate: 2,
                          ),
                  );
                  }

                });
              },
              activeTrackColor: Colors.white,
              activeColor: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}

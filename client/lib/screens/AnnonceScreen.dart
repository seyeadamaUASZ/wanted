import 'package:client/annonces/annonces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AnnonceScreen extends StatefulWidget {
  AnnonceScreen({Key? key}) : super(key: key);

  @override
  State<AnnonceScreen> createState() => _AnnonceScreenState();
}

class _AnnonceScreenState extends State<AnnonceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Center(child: Annonces(url: "annonce",)),
    );
  }
}
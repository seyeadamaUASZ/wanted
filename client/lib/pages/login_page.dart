import 'dart:convert';

import 'package:client/pages/entry_page.dart';
import 'package:client/pages/signup_page.dart';
import 'package:client/services/networkhandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool vis=true;
  final _globalkey=GlobalKey();
  NetWorkHandler netWorkHandler=NetWorkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
   String? errorText;
  bool validate=false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      body: Container(   
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
     //width: double.infinity,
     //height: double.infinity,
      decoration: const BoxDecoration(  
        // image:DecorationImage(
        //   image: AssetImage("assets/wanted.jpg"),
        //   fit: BoxFit.cover,
        //   ) ,
         gradient: LinearGradient(  
           colors: [Colors.white,Colors.blue],
           begin: const FractionalOffset(0.0, 1.0),
           end: const FractionalOffset(0.0, 1.0),
           stops: [0.0,1.0],
           tileMode: TileMode.repeated
         )
      ),
     child: Form(
       key:_globalkey,
       child: Column(  
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text("Connectez-vous !!",
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 30,
             fontWeight: FontWeight.bold,
             letterSpacing: 2,
           )),
           const SizedBox(height: 60,),
           UserNameTextField1(),
           const SizedBox(height: 30,),
           PasswordTextField1(),
           const SizedBox(height: 40,),
           
           InkWell(
             onTap:()async{
               setState(() {
                 circular=true;
               });
                 Map<String,String> data={ 
                   "username":_usernameController.text,
                   "password":_passwordController.text
                 };
                 print(data);
                 var response = await netWorkHandler.post("user/login", data);
                 print(response.body);
                 if(response.statusCode==200 || response.statusCode==201){
                   Map<String,dynamic> output = json.decode(response.body);
                   await storage.write(key: "token", value: output['token']);
                   await storage.write(key: "username", value: output['data']);
                 }
                 setState(() {
                   circular=false;     
                 });

                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EntryPage()), (route) => false);
                    
             },
             child:circular ? const CircularProgressIndicator() 
              :Container(  
               width: 360,
               height: 55,
               decoration: BoxDecoration(  
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.blue
               ),
               child: const Center(  
                 // ignore: unnecessary_const
                 child:const Text("Connecter",style:TextStyle(   
                   color:  Colors.white,
                   fontSize: 16,
                   fontWeight: FontWeight.w600
                 )),
               ),
             ),
           ),
           SizedBox(height: 20,),
             Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                  const Text("Pas de compte ? ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),),
              
                SizedBox(width: 6,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                     SignupPage()
                    ));
                  },
                  child: const Text("S'inscrire ",style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                 ]
                
                ),
         ],
       ),
     ),
        ),
      );
  }

  /*Widget usernameTextField(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(children: [
        
        //const Text("username..."),
        TextFormField(
          controller: _usernameController,
           
          decoration: InputDecoration(
            label: Text("Nom utilisateur",style:TextStyle(
              color: Colors.white
            )), 
            prefixIcon:  Icon(
              Icons.person ,
              color: Colors.white
            ),  
            errorText: validate?null: errorText ,
           focusedBorder:const UnderlineInputBorder (
             borderSide: BorderSide(color: Colors.white,width: 2),

           )  
          ),
        )
      ],),
    );
  }*/


  Widget UserNameTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _usernameController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.person ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "veuillez saisir le nom utilisateur",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }


  Widget PasswordTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.lock ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "Mot de passe",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }



  
  /*Widget passwordTextField(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(children: [
        //const Text("password...")
        TextFormField( 
          controller: _passwordController,
          validator: (value){
            if(value!.isEmpty) return "password can't be empty";
            if(value.length <=8) return "password lenght should have 8";
            return null;
          },
          obscureText: vis,
          decoration: InputDecoration(
            label: const Text("Mot de passe",style:TextStyle(
              color: Colors.white
            )),
            prefixIcon: Icon(Icons.lock,color: Colors.white,),
            suffixIcon: IconButton(  
              icon: Icon(vis ? Icons.visibility_off:Icons.visibility,color: Colors.white,),
              onPressed: (){
                setState(() {
                  vis = !vis;
                });
              },
            ),  
            
            //helperText: "password length should have >=8", 
            helperStyle: const TextStyle(   
              fontSize: 16
            ),
           focusedBorder:const UnderlineInputBorder(  
             borderSide: BorderSide(color: Colors.white,width: 2,),

           )  
          ),
        )
      ],),
    );
  }*/

}
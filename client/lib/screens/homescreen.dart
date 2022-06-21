import 'package:client/pages/login_page.dart';
import 'package:client/pages/signup_page.dart';
import 'package:client/theme/appcolor.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(  
          // image:DecorationImage(
          // image: AssetImage("assets/wanted.jpg"),
          // fit: BoxFit.cover,
          // ) ,
          gradient: LinearGradient(  
            colors: [Colors.white,Colors.blue],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0,1.0],
            tileMode: TileMode.repeated
          )
        ),
        child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
          child: Column(  
            children:<Widget> [ 
              const Text("Wanted !!",
                style: TextStyle(  
                fontSize: 38,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: Colors.black,
                fontStyle: FontStyle.italic
              ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/5,),
              const Text("Application pour les annonces des disparus",
               textAlign: TextAlign.center,
               style: TextStyle(  
                 fontWeight: FontWeight.w600,
                 fontSize: 27,
                 letterSpacing: 1
               ),
              ),
               SizedBox(height: 30,),
               boxContainer("assets/facebook1.png","Inscription Face",onFacebookLogin),
               SizedBox(height: 10,),
               boxContainer("assets/email2.png","Inscription Email",onEmailSignup),
               SizedBox(height: 20,),
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                  const Text("Déjà un compte ? ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),),
              
                SizedBox(width: 6,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                     LoginPage()
                    ));
                  },
                  child: const Text("Connecter ",style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                 ]
                
                )
            ],
          ),
        ),

      )
    );
  }

  onEmailSignup(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage()));
  }

  onFacebookLogin(){

  }

  Widget boxContainer(String path,String text,onClick){
     return InkWell(
       onTap: onClick,
       child: Container(  
          height: 65,
          width: MediaQuery.of(context).size.width -140,
          child: Card(  
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10,),
              child: Row(  
                children: [
                  Image.asset(path,height: 35,width: 35,),
                  const SizedBox(width: 20,),
                  Text(text,style: const TextStyle(  
                    fontSize: 14,color: Colors.black87
                  ),)
                ],
              ),
            ),
          ),
       ),
     );
  }
}


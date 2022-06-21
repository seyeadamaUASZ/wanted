import 'package:client/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
   IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages=[
     PageViewModel(  
       title: 'First page',
       body:'Description',
       footer: ElevatedButton(  
         onPressed: (){},
         child: Text("Suivant"),
       ),
       image:Center(  
         child: Image.asset("assets/1.png"),
       ),
       decoration:const  PageDecoration(   
         titleTextStyle: TextStyle(  
           fontSize: 25.0,
           fontWeight: FontWeight.bold
         )
       )
     ),
     PageViewModel(  
       title: 'Second page',
       body:'Description',
       footer: ElevatedButton(  
         onPressed: (){},
         child: Text("Suivant"),
       ),
       image:Center(  
         child: Image.asset("assets/2.png"),
       ),
       decoration:const  PageDecoration(   
         titleTextStyle: TextStyle(  
           fontSize: 25.0,
           fontWeight: FontWeight.bold
         )
       )
     ),
     PageViewModel(  
       title: 'Third page',
       body:'Description',
       footer: ElevatedButton(  
         onPressed: (){},
         child: Text("Terminé"),
       ),
       image:Center(  
         child: Image.asset("assets/3.png"),
       ),
       decoration:const  PageDecoration(   
         titleTextStyle: TextStyle(  
           fontSize: 25.0,
           fontWeight: FontWeight.bold
         )
       )
     ),

  ]; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: const Text("Wanted !!"),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: IntroductionScreen(  
          pages: pages,
          dotsDecorator:const DotsDecorator(  
            size: Size(15,15),
            color:Colors.blue,
            activeSize: Size.square(20),
            activeColor: Colors.red
          ),
          showDoneButton: true,
          done: Text("Terminé",style: TextStyle(
            fontSize: 20
          ),),
          showSkipButton: true,
          skip: const Text("Quitter",style:TextStyle(
            fontSize: 20
          )),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward,size: 20,),
          onDone: ()=>onDone(context),
          curve: Curves.bounceOut,
        ),
      )
    );
  }

  void onDone(context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  }
}
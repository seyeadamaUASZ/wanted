import 'package:client/services/networkhandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnonceCard extends StatelessWidget {
  const AnnonceCard({Key? key,required this.title,
  required this.id,required this.classee,
  required this.description,
  required this.netWorkHandler}) : super(key: key);
  final String title;
  final String id;
  final bool classee;
  final String description;
  final NetWorkHandler netWorkHandler;

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 330,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        child: Stack(  
          children: <Widget>[
            Container(  
              height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              
              decoration: BoxDecoration(  
                image: DecorationImage(  
                  image: netWorkHandler.getImage1(id),
                  fit:BoxFit.fitWidth,
                  

                )
              ),
            ),
            Positioned(
              bottom: 1,
             child:
             Container( 
               padding: EdgeInsets.all(8),
               height: 50,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(  
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(4)
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(title, textAlign: TextAlign.center,style: TextStyle(  
                         fontWeight:FontWeight.bold,
                         fontSize: 15, 
                       ),),
                       SizedBox(width: 8,),
                       Text(classee==false ? "Cherché" : "Trouvé",style: TextStyle(  
                         color: classee==false ? Colors.red : Colors.green
                       ),)
                     ],
                   ),
                   SizedBox(height: 2,),
                   Expanded(
                     child: Text(description,
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                     ),
                   )
                 ],
                
               ),
             )
            )
          ],
        ),
      ),
    );
  }
}
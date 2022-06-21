import 'dart:convert';

import 'package:client/pages/entry_page.dart';
import 'package:client/services/networkhandler.dart';
import 'package:client/widgets/customDialog.dart';
import 'package:client/widgets/previsualiser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAnnonce extends StatefulWidget {
  AddAnnonce({Key? key}) : super(key: key);

  @override
  State<AddAnnonce> createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _contact = TextEditingController();

  ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  IconData iconphoto = Icons.image;
  NetWorkHandler netWorkHandler = NetWorkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        backgroundColor: Colors.blue[200],
        elevation: 0,
        title: Text("Nouvelle !",style: TextStyle(fontStyle: FontStyle.italic),),
        centerTitle: true,
        leading: IconButton(  
          icon: Icon(Icons.clear,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(onPressed: (){
           if(_imageFile?.path != null){
              showModalBottomSheet(context: context,
               builder: (builder)=>Previsualiser(imageFile: _imageFile!));
           }
          }, 
          child:Text("prévisualiser",
           style: TextStyle(  
             fontSize: 15,
             color:Colors.white
           ),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:65),
        child: Form(  
          key:_globalkey,
          child: ListView(  
            children: [
              titleTextField(),
              SizedBox(height: 15,),
              ContactTextFiel(),
              SizedBox(height: 15,),
              DescriptionTextField(),
              SizedBox(height: 35,),
              addButton()
            ],
          ),
        ),
      )
    );
  }
  
  Widget titleTextField(){
    return Padding(  
      padding:const EdgeInsets.symmetric(  
        horizontal: 10,
        vertical:10
      ),
      child: TextFormField(  
        controller: _title,
        validator: (value){
          if(value!.isEmpty){
            return "Nom du disparu ne doit pas être nul";
          }
          return null;
        },
        decoration: InputDecoration(  
          border: OutlineInputBorder(  
            borderSide: BorderSide(  
              color: Colors.blue,
            )
          ),
          focusedBorder: OutlineInputBorder(  
            borderSide: BorderSide(  
              color: Colors.blue,
              width: 2
            )
          ),
          labelText: "Ajouter l'image et le nom",
          prefixIcon: IconButton(  
            icon: Icon(iconphoto,color: Colors.blue,),
            onPressed: takeCoverPhoto,
          )
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget ContactTextFiel(){
    return Padding(  
      padding:const EdgeInsets.symmetric(  
        horizontal: 10,
        vertical:10
      ),
      child: TextFormField(  
        controller: _contact,
        validator: (value){
          if(value!.isEmpty){
            return "le contact ne doit pas être nul";
          }
          return null;
        },
        decoration: InputDecoration(  
          border: OutlineInputBorder(  
            borderSide: BorderSide(  
              color: Colors.blue,
            )
          ),
          focusedBorder: OutlineInputBorder(  
            borderSide: BorderSide(  
              color: Colors.blue,
              width: 2
            )
          ),
          labelText: "Contact (telephone ou email)",
          prefixIcon: Icon(Icons.person,color: Colors.blue,) 
        ),
        maxLength: 50,
      ),
    );

  }


  Widget DescriptionTextField(){
    return Padding(
      padding: const EdgeInsets.symmetric( 
        horizontal: 10
      ),
      child: TextFormField( 
        controller: _description,
        validator:(value){
          if(value!.isEmpty){
            return "La description ne peut être nulle!!";
          }
          return null;
        } , 
        decoration: InputDecoration(  
          border: OutlineInputBorder(  
            borderSide: BorderSide(   
              color:Colors.blue
            )
          ),
          focusedBorder: OutlineInputBorder(  
            borderSide: BorderSide(  
              color:Colors.blue,
              width: 2
            )
          ),
          labelText: "Décrivez les circonstances de disparutions",
         
          
        ),
        maxLines: 6,
      ),
    );
  }


  Widget addButton(){
    return InkWell(
      onTap: ()async{
      //     if(_imageFile!=null && _globalkey.currentState.validate()){
      //       AddBlogModel addBlogModel = AddBlogModel(body: _body.text,title: _title.text);
      //       var response = await networkHandler.post1("blogpost/Add", addBlogModel.toJson());
      //       print(response.body);
      //       if(response.statusCode==200 || response.statusCode==201){
      //          String id = json.decode(response.body)['data'];
      //         var imageResponse = await netWorkHandler.patchImage("blogpost/add/coverImage/$id", _imageFile.path);
      //      if(imageResponse.statusCode==200 || imageResponse.statusCode==201){
      //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      //       }   
      //       }
      //     }

      if(_imageFile!=null && _globalkey.currentState?.validate()==true){
           Map<String,String> data={
              "title":_title.text,
              "contact":_contact.text,
              "description":_description.text
            };
            var response = await netWorkHandler.post1("annonce/add", data);
            print(response.body);
            if(response.statusCode==200 || response.statusCode==201){
               String id = json.decode(response.body)['data'];
               var imageResponse = await netWorkHandler.patchImage("annonce/add/coverImage/$id", _imageFile!.path);
               if(imageResponse.statusCode==200 || imageResponse.statusCode==201){
                   
                  //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EntryPage()), (route) => false);
                  showDialog(
                     context: context,
                      builder: (BuildContext context) => CustomDialog(
                            title: "Success",
                            description:
                                "L'annonce publiée à succes",
                            buttonText: "Ok",
                            currentNavigate: 0,
                          ),
                  ); 
             } 
             }
      }
       },
      child: Center(
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue
          ),
          child:Center(child: Text("Publier",
          style: TextStyle(  
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          )) ,
        ),
      ),
    );
  }


  void takeCoverPhoto()async{
    final coverPhoto = await _picker.getImage(
       source: ImageSource.gallery);
    setState(() {
      _imageFile=coverPhoto;
      iconphoto=Icons.check_box;
    });
  }


}